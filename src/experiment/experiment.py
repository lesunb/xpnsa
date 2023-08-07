import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


import config.config as conf
from .data_gen import DataGenerator
from .sensor import ExperimentSensor

SENSORS = {
    'oximeter':{
        'sensor_lower_bound':70,
        'sensor_upper_bound':100},
    'temperature':{
        'sensor_lower_bound':34.5,
        'sensor_upper_bound':40},
    'heartrate':{
        'sensor_lower_bound':50,
        'sensor_upper_bound':200},
    'abpd':{
        'sensor_lower_bound':50,
        'sensor_upper_bound':150},
    'abps':{
        'sensor_lower_bound':100,
        'sensor_upper_bound':200},
}

class Experiment():
    def __init__(self, parameters_file:str=None, size:int=1):
        if parameters_file is not None:
            self.parameters_file = parameters_file
            self.params = conf.get_config(parameters_file)
            self.sensors = [ExperimentSensor(
                                                size = self.params.sample_size, 
                                                **sensor
                                            ) for sensor in self.params.sensors.values()]
        self.config = conf.get_config('config')
        self.size = size
        self.df = None

    def convert_file_to_modelica_input(self, filename, outdir):
        modelica_dir = os.path.join(outdir, 'modelica_input')
        if not os.path.exists(modelica_dir):
            os.mkdir(modelica_dir)

        line1 = "#1"
        line2 = f"double measurement{self.df.shape[0], self.df.shape[1]+1} # {list(self.df.columns)}"
        dummy_file = os.path.join(
                                    outdir,
                                    'modelica_input',
                                    os.path.splitext(filename)[0] + '.txt'
                                )
        filename = os.path.join(outdir, 'dataframe', filename)
        with open(filename, 'r') as read_obj, open(dummy_file, 'w') as write_obj:
            write_obj.write(line1 + '\n')
            read_obj.readline()
            write_obj.write(line2 + '\n')

            for line in read_obj:
                write_obj.write(line)

    def save_data(self, seed:int, outdir:str, format:str=None):
        outdir = os.path.join(self.config.DATA_PATH, outdir)
        filename = f"sensors_data_seed{seed}.csv"
        df_dir = os.path.join(outdir, 'dataframe')

        if not os.path.exists(outdir):
            os.mkdir(outdir)
            os.mkdir(df_dir)

        self.df.to_csv(os.path.join(df_dir, filename))
        
        if format == 'csv':
            return
        
        self.convert_file_to_modelica_input(filename, outdir)

    def get_subsamples(self, gen: DataGenerator, subsamples_shapes:list[int], sensor_upper_bound, sensor_lower_bound, subsample_total_size, seed):
        if seed >= 0:
            np.random.seed(seed)
        subsamples = dict()

        shapes = [gen.get_function_by_cod(cod) for cod in subsamples_shapes]
        old_lower_bound = old_upper_bound = np.random.uniform(sensor_lower_bound, sensor_upper_bound)
        last_shape = 'stable'
        perc = (sensor_upper_bound - sensor_lower_bound) / 100

        for i, shape in zip(range(subsample_total_size), shapes):
            if shape == 'crescent':
                # print(shape)
                if last_shape in ['stable', 'decrescent']:
                    lower_bound = old_lower_bound
                    upper_bound = np.random.uniform(lower_bound, sensor_upper_bound)
                elif last_shape == 'crescent':
                    lower_bound = old_upper_bound
                    upper_bound = np.random.uniform(lower_bound, sensor_upper_bound)
            elif shape == 'decrescent':
                # print(shape)
                if last_shape in ['stable', 'crescent']:
                    upper_bound = old_upper_bound
                    lower_bound = np.random.uniform(sensor_lower_bound, upper_bound)
                elif last_shape == 'decrescent':
                    upper_bound = old_lower_bound
                    lower_bound = np.random.uniform(sensor_lower_bound, upper_bound)
            elif shape == 'stable':
                # print(shape)
                if last_shape == 'crescent':
                    middle = old_upper_bound 
                elif last_shape == 'decrescent':
                    middle = old_lower_bound 
                elif last_shape == 'stable':
                    middle = (old_upper_bound + old_lower_bound ) / 2

                upper_bound = middle + perc
                if upper_bound > sensor_upper_bound:
                    upper_bound = sensor_upper_bound       
                lower_bound = middle - perc

                if lower_bound < sensor_lower_bound:
                    lower_bound = sensor_lower_bound
            sample = { f'subsample_{i}': {
                                        'shape': shape,
                                        'lower_bound': lower_bound,
                                        'upper_bound': upper_bound,
                                        'size': 1 if i < subsample_total_size - 1 else 0
                                        }
                                    }
            last_shape = shape
            old_lower_bound = lower_bound
            old_upper_bound = upper_bound
            subsamples.update(sample)
        return subsamples

    def create_patient_profile(self, seed=-1, sensors=SENSORS):
        if seed >= 0:
            np.random.seed(seed)
        subsample_sizes = np.random.randint(low=7, high=10, size=len(sensors.keys()))
        all_subsamples = np.random.randint(3, size=subsample_sizes.sum())
        subsamples_shapes_list = np.split(all_subsamples, np.cumsum(subsample_sizes)[:-1])

        for sensor, subsamples_shapes in zip(sensors.keys(), subsamples_shapes_list):
            sensors[sensor]['subsample_total_size'] = len(subsamples_shapes)

            sensors[sensor]['subsamples'] = self.get_subsamples(
                                                    DataGenerator(), 
                                                    subsamples_shapes,
                                                    sensor_upper_bound = sensors[sensor]['sensor_upper_bound'], 
                                                    sensor_lower_bound = sensors[sensor]['sensor_lower_bound'], 
                                                    subsample_total_size = sensors[sensor]['subsample_total_size'], 
                                                    seed = seed
                                                )
        self.params = sensors

        self.sensors = [ExperimentSensor(
                        size = self.size, 
                        name = name,
                        **sensor
                    ) for name, sensor in self.params.items()]
    
    def plot_sensors_data(self):
        _, ax = plt.subplots(2, 3, sharex=True, figsize=(15,10))

        ax[0,0].plot(self.df.index, self.df.abpd)
        ax[0,1].plot(self.df.index, self.df.abps)
        ax[0,2].plot(self.df.index, self.df.heartrate)
        ax[1,0].plot(self.df.index, self.df.oximeter)
        ax[1,1].plot(self.df.index, self.df.temperature)

        ax[0,0].set_title('Abpd')
        ax[0,1].set_title('Abps')
        ax[0,2].set_title('heartrate')
        ax[1,0].set_title('oximeter')
        ax[1,1].set_title('temperature')

        plt.show()

    def generate_sensors_data(self, seed:int=-1):
        df = pd.DataFrame(index=range(self.size))
        df.index.names = ['index']
        for sensor in self.sensors:
            sensor.generate_data(seed)
            df[sensor.name] = sensor.values  
        df['timestamp'] = df.index / 10

        self.df = df[df.timestamp.astype(int) == df.timestamp].set_index('timestamp')
        

    def create_experiment(self, format:str='modelica'):
        for seed in range(self.size):
            self.generate_sensors_data(seed)
            self.save_data(seed, format)