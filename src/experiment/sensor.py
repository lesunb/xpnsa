import numpy as np
from .data_gen import DataGenerator
from .range import Range

class ExperimentSensor:
    """ Class that holds and generates the data of a single sensor.
    
    This class is called during the parse of the experiment config yaml file. 
    The generation of the data is handled by the DataGenerator class.
    """
    def __init__(self, name:str, size:int, subsample_total_size:int, subsamples:dict, sensor_upper_bound:float, sensor_lower_bound:float):
        """Constructor of the class.

        Args:
            name (str): Name of the sensor.
            size (int): how many data points the sensor data will contain.
            subsample_total_size (int): In how many parts the data will be split.
                for example: if subsample_total_size == 8, the first 1/8 will be crescent,
                the second will be stable, and so on.
            subsamples (dict): A dictionary with the parameters for creating each part of
                the dataset.
        """
        self.name = name
        self.size = size
        self.sensor_upper_bound = sensor_upper_bound
        self.sensor_lower_bound = sensor_lower_bound
        self.subsample_total_size = subsample_total_size
        self.part = round(self.size/self.subsample_total_size)
        self.subsamples = subsamples
        self.values = np.array([])
        self.gen = DataGenerator()
    
    def generate_data(self, seed:int=-1):
        """Method responsible for generating the sensor's data.
        This method loops through the dictionary with the subsample's configuration and
        calls the DataGenerator class to create the data based on the read config.

        Args:
            seed (int, optional): seed value for replicability. Defaults to -1.
        """
        if len(self.values) > 0: # reset 
            self.values = np.array([])

        for subsample in self.subsamples.values():

            if subsample['size'] == 0:  # last sample
                size = self.size - len(self.values)
            else:
                size = self.part * subsample['size']

            data = {
                'stable': self.gen.create_stable_data(rang = Range(subsample['lower_bound'], 
                                                                   subsample['upper_bound']), 
                                                      size = size,
                                                      seed = seed),
                'crescent': self.gen.create_gradual_change(new_range = Range(subsample['lower_bound'], 
                                                                             subsample['upper_bound']),
                                                           size = size, 
                                                           crescent = True,
                                                           seed = seed),
                'decrescent':self.gen.create_gradual_change(new_range = Range(subsample['lower_bound'], 
                                                                              subsample['upper_bound']),
                                                            size = size, 
                                                            crescent = False,
                                                            seed = seed),
            }[subsample['shape']]
            self.values = np.append(self.values, data)