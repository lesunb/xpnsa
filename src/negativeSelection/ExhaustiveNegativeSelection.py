import numpy as np
from . import NegativeSelection

class ExhaustiveNegativeSelectionAlgorithm(NegativeSelection):

    def __init__(self, n_detectors:int, alphabet:list, detector_string_size:int, seed:int):
        self.n_detectors = n_detectors
        self.alphabet = alphabet
        self.detector_string_size = detector_string_size
        self.nonself_detectors = set()
        self.self_detectors = set()
        self.seed = seed
        self.self_data = None

    def generateDetector(self) -> str:
        detectorString = [self.alphabet[value] for value in np.random.randint(low = 0,
                                                                              high = len(self.alphabet), 
                                                                              size = self.detector_string_size)
                            ]
        return "".join(detectorString)

    def testDetector(self, potential_detector:str) -> bool:
        if potential_detector in self.self_data:
            return False
        return True

    def fit(self, X):
        self.self_data = X
        self.nonself_detectors = set()
        self.self_detectors = set()

        while (len(self.nonself_detectors) < self.n_detectors):
            potential_detector = self.generateDetector()

            if ((potential_detector in self.self_detectors) or 
                (potential_detector in self.nonself_detectors)):
                continue # don't bother to test it if already exists!
            
            if self.testDetector(potential_detector):
                self.nonself_detectors.add(potential_detector)
            else:
                self.self_detectors.add(potential_detector)