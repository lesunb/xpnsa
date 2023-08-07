import pandas as pd
import numpy as np
import scipy.spatial.distance as distance

def signal2string(X:pd.DataFrame):
    return ["".join(value.astype(str)) for value in X.fillna(0).astype(int).to_numpy()]

def generate_string(alphabet, size):
    detectorString = [alphabet[value] for value in np.random.randint(low = 0,
                                                                        high = len(alphabet), 
                                                                        size = size)
                            ]
    return "".join(detectorString)

def calculate_r_contiguous_matches(chunk, begin, set):
    end = begin + len(chunk)
    if end > set.str.len()[0]:
        print('error! Index not found!')
    return (set
            .to_frame()
            .assign(sliced_str = set.str.slice(start=begin, stop=end))
            .assign(position = begin)
            .assign(match = lambda x: x.sliced_str.str.contains(chunk))
        )

def calculate_hamming(det, set, threshold):
    return (set
            .to_frame()
            .assign(distance = set.map(lambda x: distance.hamming(x, det)))
            .assign(match = lambda x: x.distance <= threshold)
            )

def calculate_rogerstanimoto(det, set, threshold):
    return (set
            .to_frame()
            .assign(distance = set.map(lambda x: distance.rogerstanimoto(x, det)))
            .assign(match = lambda x: x.distance <= threshold)
            )


def match_r_contiguous(det, begin, set):
    s = calculate_r_contiguous_matches(det, begin, set)
    return len(s.query('match == True')) > 1

def match_hamming(det, set, threshold):
    s = calculate_hamming(det, set, threshold)
    return len(s.query('match == True')) > 1

def match_rogerstanimoto(det, set, threshold):
    s = calculate_rogerstanimoto(det, set, threshold)
    return len(s.query('match == True')) > 1