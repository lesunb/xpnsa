import os
from typing import Callable

import pandas as pd
import numpy as np

import config.config as conf

class SensorMarkovChain():   
    
    def __init__(self, rng:Callable, config_file:str):
        self.rng = rng
        config = conf.get_config(config_file)

        self.transition_matrix = pd.DataFrame(config.transition_matrix).cumsum(axis=1)
        self.sensor_ranges = config.states

        self.state = self.generate_random_state()
        self.higher_state = max(self.sensor_ranges.keys())
    
    def generate_random_state(self):
        return self.rng.choice(list(self.sensor_ranges.keys()))
    
    def generate_state_value(self, state=None):
        if state is None:
            state = self.state
        return self.rng.uniform(*self.sensor_ranges[state])
    
    def set_next_state(self):
        transition_value = self.rng.random()
        new_state = np.digitize(transition_value, bins=self.transition_matrix.iloc[self.state])
        
        self.state = new_state if new_state <= self.higher_state else self.higher_state

    def get_list_values(self, size:int):
        values = list()
        for _ in range(size):
            values.append(self.generate_state_value())
            self.set_next_state()
        return values
    

def generate_sensors_data(sample_size:int, id:int, rng:Callable, config_path:str) -> pd.DataFrame: 
    sensors_data = pd.DataFrame(index=range(sample_size))

    sensors_data['oximeter'] = SensorMarkovChain(rng=rng, config_file=f'{config_path}\\SaO2_mc').get_list_values(sample_size)
    sensors_data['temperature'] = SensorMarkovChain(rng=rng, config_file=f'{config_path}\\Temp_mc').get_list_values(sample_size)
    sensors_data['heartrate'] = SensorMarkovChain(rng=rng, config_file=f'{config_path}\\HR_mc').get_list_values(sample_size)
    sensors_data['abpd'] = SensorMarkovChain(rng=rng, config_file=f'{config_path}\\NIDiasABP_mc').get_list_values(sample_size)
    sensors_data['abps'] = SensorMarkovChain(rng=rng, config_file=f'{config_path}\\NISysABP_mc').get_list_values(sample_size)
    sensors_data['patient_id'] = id
    sensors_data['category'] = config_path.replace('\\','_')

    return sensors_data

def convert_file_to_modelica_input(df, filename, outdir):
    modelica_dir = os.path.join(outdir, 'modelica_input')
    if not os.path.exists(modelica_dir):
        os.mkdir(modelica_dir)

    line1 = "#1"
    line2 = f"double measurement{df.shape[0], df.shape[1]+1} # {list(df.columns)}"
    dummy_file = os.path.join(
                                outdir,
                                'modelica_input',
                                os.path.splitext(filename)[0] + '.txt'
                            )
    filename = os.path.join(outdir, 'dataframe', filename + '.csv')
    with open(filename, 'r') as read_obj, open(dummy_file, 'w') as write_obj:
        write_obj.write(line1 + '\n')
        read_obj.readline()
        write_obj.write(line2 + '\n')

        for line in read_obj:
            write_obj.write(line)