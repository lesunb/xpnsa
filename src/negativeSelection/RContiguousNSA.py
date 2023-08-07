import pandas as pd

from .string_operations import generate_string, signal2string
from . import NegativeSelection

class RContiguousNSA(NegativeSelection):
    def __init__(self, r, n_detectors, alphabet):
        self.r = r
        self.n_detectors = n_detectors
        self.alphabet = alphabet
        self.nonself_detectors = set()
        self.self_detectors = set()
    
    def calculate_r_contiguous_matches(self, chunk, begin):
        end = begin + len(chunk)
        if end > self.self_str.str.len()[0]:
            print('error! Index not found!')
        return (self.self_str
                .to_frame()
                .assign(sliced_str = self.self_str.str.slice(start=begin, stop=end))
                .assign(position = begin)
                .assign(match = lambda x: x.sliced_str.str.contains(chunk))
            )
    
    def match_r_contiguous(self, det, begin):
        s = self.calculate_r_contiguous_matches(det, begin)
        return len(s.query('match == True')) > 1

    def generateDetector(self):
        return generate_string(self.alphabet, self.self_str.str.len()[0])

    def testDetector(self, chunk, pos) -> bool:
        return not self.match_r_contiguous(chunk, pos)

    def match_single_str(self, nonself_str):
        for detector in self.nonself_detectors.values:
            for i in range(len(nonself_str) - self.r):
                if detector[i : i + self.r] == nonself_str[i : i + self.r]:
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
            chunks = [detector[i: j] for i in range(len(detector))
                                for j in range(i + 1, len(detector) + 1) if len(detector[i: j]) == self.r]
            detector = pd.Series(detector)
            # print(detector)
            found_self = False
            for pos, chunk in enumerate(chunks):
                if not self.testDetector(chunk, pos):
                    found_self = True
                    self.self_detectors = pd.concat([self.self_detectors, detector]).drop_duplicates()
                    # print(pos, chunk)
                    break
            # print(found_self)
            if not found_self:
                self.nonself_detectors = pd.concat([self.nonself_detectors, detector]).drop_duplicates()
                print(f" {detector.values[0]} Nonself detector added! {len(self.nonself_detectors)} in total")

    def predict(self, X_test):
        X_test = X_test.assign(self_str = lambda x: signal2string(x))
        return X_test.self_str.apply(self.match_single_str)

