import sys
import os
sys.path.append('../config')

import numpy as np
import pandas as pd
from OMPython import OMCSessionZMQ
from OMPython import ModelicaSystem
import DyMat, DyMat.Export

import logging

from config import get_config

class OMSimulator:
    def __init__(self, **kwargs):
        logging.info("[Simulator] Instantiating simulator!")
        self.omc = OMCSessionZMQ()

        self.config = get_config(kwargs.get('configFile', 'ome_simulation_config'))
        self.startTime = kwargs.get('startTime', self.config.startTime)
        self.stopTime = kwargs.get('stopTime', self.config.stopTime)
        
        self.model_path = os.path.join(*self.config.MODELS_PATH)
        self.main_model_file = os.path.join(self.model_path, self.config.MAIN_MODEL_FILE)
        self.other_models_list = [os.path.join(self.model_path, file) for file in os.listdir(self.model_path) if file != self.config.MAIN_MODEL_FILE]
        self.data_path = os.path.join(*self.config.DATA_PATH, self.config.EXPERIMENT)
        self.model = None


        logging.info(f"[Simulator] Model Path: {self.model_path}")
        logging.info(f"[Simulator] Main Model File: {self.main_model_file}")
        logging.info(f"[Simulator] Sensor's data Files: {self.data_path}")
        logging.info(f"[Simulator] Other Models: {self.other_models_list}")
        logging.info(f"[Simulator] Simulation Start Time: {self.startTime}")
        logging.info(f"[Simulator] Simulation Stop Time: {self.stopTime}")
        logging.info(f"[Simulator] Result Columns: {self.config.RESULT_COLUMNS}")

    
    def set_up_model(self):
        logging.info("[Simulator] Setting up Model")

        logging.info("[Simulator] Loading Model")
        self.model = ModelicaSystem(
                        self.main_model_file,
                        self.config.MAIN_MODEL_NAME,
                        ["Modelica", *self.other_models_list]
                    )
        logging.info("[Simulator] Building Model")
        self.model.buildModel()
        logging.info("[Simulator] Setting Simulation Options")
        self.model.setSimulationOptions([f"startTime={self.startTime}", f"stopTime={self.stopTime}"])
        
        return self

    def clean_up(self):
        logging.info("[Simulator] Cleaning up auto generated files")
        [os.remove(f) for f in os.listdir() if (('.o' in f) 
                                                or ('.c' in f) 
                                                or ('.h' in f) 
                                                or ('.json' in f) 
                                                or ('.xml' in f) 
                                                or ('.bat' in f) 
                                                or ('.exe' in f) 
                                                or ('.libs' in f) 
                                                or ('.log' in f) 
                                                or ('.makefile' in f))
        ]
        return self

    def set_new_parameters(self, seed):
        """Sets new parameters for the BSN Modelica model.
        It sets a parameter that randomizes how fast the battery runs out
        for each sensor, and chooses the file and the global seed that will
        be used in the simulation.

        Args:
            seed (int): integer value for replicability

        Returns:
            _type_: ModelicaSystem model with redefined parameters
        """
        logging.info(f"[Simulator] Setting Parameters")

        np.random.seed(seed)

        sensors = ['Abpd','Abps','HeartRate','Oximeter','temperature']
        battery_gain = np.random.randint(low=10000, high=20000, size=len(sensors))
        logging.info(f"[Simulator] Random Battery Gains defined: {dict((x, y) for x, y in zip(sensors, battery_gain))}")
        
        sensors_data = os.path.join(self.data_path, 'modelica_input',f'patient_{seed}.txt')
        logging.info(f"[Simulator] Sensor's data file: {sensors_data}")

        logging.info(f"[Simulator] Setting parameters")
        logging.info(f"[Simulator] Setting Battery Gains")
        for sensor, gain in zip(sensors, battery_gain):
            self.model.setParameters(f'{sensor}.battery_gain={gain}')
        
        logging.info(f"[Simulator] Setting Global seed and Sensor's data file")
        self.model.setParameters([f"globalSeed.fixedSeed={seed}",f"sensor_measurements.fileName={sensors_data}"])
        return self

    def convert_from_mat(self, input_file:str, **kwargs):
        """Reads a .mat file and saves as a .csv or a .parquet file

        The process is executed in two steps:
            1. Using the DyMat lib, the .mat file is converted to csv
            2. Using the Pandas lib, de .csv file is saved as parquet

        Args:
            input_file (str): _description_
        """
        logging.info(f"[Simulator] Exporting data to parquet")

        final_format = kwargs.get('final_format', 'parquet')
        output_path = kwargs.get('output_file', os.path.join(self.data_path, 'modelica_output'))
        drop_files = kwargs.get('drop_files', True)

        output_csv = os.path.join(output_path, f'{input_file}.csv')
        output_parquet = os.path.join(output_path, f'{input_file}.parquet')
        logging.info(f"[Simulator] Output file: {output_parquet}")

        logging.info(f"[Simulator] Converting from .mat to .csv")
        d = DyMat.DyMatFile(input_file + ".mat")
        logging.debug(f"[Simulator] Resulting Columns: {d.names()}")
        DyMat.Export.export('CSV', d, self.config.RESULT_COLUMNS, fileName=output_csv)
        if drop_files:
            logging.info(f"[Simulator] Removing .mat file")
            os.remove(input_file+".mat")

        if final_format == 'csv':
            return

        logging.info(f"[Simulator] Converting from .csv to .parquet")
        df = pd.read_csv(output_csv)
        df.to_parquet(output_parquet)
        if drop_files:
            logging.info(f"[Simulator] Removing .csv file")
            os.remove(output_csv)

    def run_simulation_seed(self, seed):
        logging.info(f"[Simulator] Running Simulation for seed {seed}")
        self.set_new_parameters(seed)

        logging.info(f"[Simulator] Starting Simulation...")
        result_file = f"patient_{seed}"
        try:
            self.model.simulate(resultfile= result_file + ".mat")
        except Exception as e:
            logging.error(f"[Simulator] Failed to run simulation for patient id: {seed}")
            logging.error(e)
        logging.info(f"[Simulator] Simulation ran successfully!")

        self.convert_from_mat(result_file)
        logging.info(f"[Simulator] Data Exported!")
        logging.info(f"[Simulator] Finished Running Simulation for seed {seed}")
        
        return self

    def run_batch_simulations(self, how_many:int):
        logging.info(f"[Simulator] Starting to Run {how_many} Simulations")
        for seed in range(how_many):
            print(seed)
            self.run_simulation_seed(seed)
        logging.info(f"[Simulator] Finished running all the Simulations")
        return self