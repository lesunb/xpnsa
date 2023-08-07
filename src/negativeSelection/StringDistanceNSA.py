import pandas as pd
from rapidfuzz import string_metric

from .string_operations import generate_string, signal2string
from . import NegativeSelection

class StringDistanceNSA(NegativeSelection):
    def __init__(self, r, n_detectors, alphabet, threshold, distance_funct='hamming'):
        self.r = r
        self.n_detectors = n_detectors
        self.alphabet = alphabet
        self.threshold = threshold
        self.distance_funct = string_metric.normalized_hamming
        # self.distance_funct = {
        #                             'hamming':distance.hamming,
        #                             'rogerstanimoto': distance.rogerstanimoto
        #                         }[distance_funct]
        self.nonself_detectors = set()
        self.self_detectors = set()
    
    def calculate_distance(self, det):
        return (self.self_str
                .to_frame()
                .assign(distance = set.map(lambda x: self.distance_funct(x, det)))
                .assign(match = lambda x: x.distance <= self.threshold)
                )

    def match(self, det):
        s = self.calculate_distance(det)
        return len(s.query('match == True')) > 1

    def generateDetector(self):
        return generate_string(self.alphabet, self.self_str.str.len()[0])

    def testDetector(self, detector) -> bool:
        return not self.match(detector)

    def match_single_str(self, nonself_str):
        for detector in self.nonself_detectors:
            if self.distance_funct(detector, nonself_str) <= self.threshold:
                return 1
        return 0

    def fit(self, X_train, y_train):
        self.nonself_detectors = pd.Series() #reset 
        self.self_detectors = pd.Series()
        self.features = X_train.columns

        X_train = X_train.assign(self_str = lambda x: signal2string(x))

        self.self_df = X_train.loc[y_train == 0]
        self.self_str = self.self_df.self_str
        self.nonself_df = X_train.loc[y_train == 1]

        while (len(self.nonself_detectors) < self.n_detectors):
            detector = self.generateDetector()
            
            if not self.testDetector(detector):
                print(f" {detector} Nonself detector added! {len(self.nonself_detectors)} in total")
                self.nonself_detectors = pd.concat([self.nonself_detectors, pd.Series(detector)]).drop_duplicates()
            else:
                self.self_detectors = pd.concat([self.self_detectors, detector]).drop_duplicates()

    def predict(self, X_test):
        X_test = X_test.assign(self_str = lambda x: signal2string(x))
        return X_test.self_str.apply(self.match_single_str)