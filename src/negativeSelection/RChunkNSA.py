import pandas as pd

from .string_operations import generate_string, signal2string
from . import NegativeSelection

class RChunkNSA(NegativeSelection):
    def __init__(self, r, n_detectors, alphabet, retries=1000):
        self.r = r
        self.n_detectors = n_detectors
        self.alphabet = alphabet
        self.retries = retries
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
        return generate_string(self.alphabet, self.r)

    def testDetector(self, chunk, pos) -> bool:
        return not self.match_r_contiguous(chunk, pos)

    def match_single_str(self, nonself_str):
        for position in  self.nonself_detectors.position.unique():
            nonself_str_chunk = nonself_str[position : (position + self.r)]
            for chunk in self.nonself_detectors.query('position == @position').chunk.values:
                if chunk == nonself_str_chunk:
                    return 1
        return 0

    def fit(self, X_train, y_train):
        self.nonself_detectors = pd.DataFrame(columns = ['position','chunk']) #reset 
        self.self_detectors = pd.DataFrame(columns = ['position','chunk'])
        self.features = X_train.columns

        X_train = X_train.assign(self_str = lambda x: signal2string(x))

        self.self_df = X_train.loc[y_train == 0]
        self.self_str = self.self_df.self_str
        self.nonself_df = X_train.loc[y_train == 1]

        count = 0

        while (len(self.nonself_detectors) < self.n_detectors) and (count <= self.retries):
            chunk = self.generateDetector()

            for pos in range(self.self_str.str.len().values[0] - self.r):
                detector = pd.DataFrame([[pos, chunk]], columns = ['position','chunk'])
                if self.testDetector(chunk, pos):
                    if len(self.nonself_detectors.query('position == @pos').query('chunk == @chunk')) > 0:
                        count += 1
                        continue
                    count = 0
                    self.nonself_detectors = pd.concat([self.nonself_detectors, detector]).drop_duplicates()
                    # print(f" {[pos, chunk]} Nonself detector added! {len(self.nonself_detectors)} in total")
                else:
                    self.self_detectors = pd.concat([self.self_detectors, detector]).drop_duplicates()

    def predict(self, X_test):
        X_test = X_test.assign(self_str = lambda x: signal2string(x))
        return X_test.self_str.apply(self.match_single_str)

