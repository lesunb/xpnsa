from abc import ABC, abstractmethod

class NegativeSelection(ABC):
    @abstractmethod
    def generateDetector(self) -> str:
        pass

    @abstractmethod
    def testDetector(self) -> bool:
        pass