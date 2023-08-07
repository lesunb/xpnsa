import sys
import os
import glob
sys.path.append('../config')

import logging
import pandas as pd
import numpy as np

from config import get_config
from .dfhandler import (get_signal_change, creating_signal_start_finish_id, 
                        creating_signal_available_id, get_object_cols, 
                        get_features_by_sensor, failure_detect,
                        property_violation_detect, save_dataset)

class Processor:
    def __init__(self, **kwargs):
        logging.info("[Processor] Instantiating Data Processor!")
        
        self.config = get_config(kwargs.get('configFile', 'data_process'))

        self.df = None
        self.df_trace = dict()

        logging.info(f"[Processor] Data Path: {os.path.join(*self.config.DATA_PATH)}")
        logging.info(f"[Processor] Wrangle Path: {os.path.join(*self.config.WRANGLE_PATH)}")

    def read_dataframe(self, filename:str) -> pd.DataFrame:
        logging.info(f"[Processor] Reading file: {filename}")
        self.df = (pd
            .read_parquet(os.path.join(*self.config.DATA_PATH, filename))
            .drop_duplicates()
            .filter(self.config.INPUT_COLUMNS)
            .reset_index()
            .replace(-np.inf, 0) # first pass through moving average gives -inf
        )
        self.df.columns = [col.lower().replace('.','_') for col in self.df.columns]
        self.df.columns = [col.replace('centralnode', 'centralhub') for col in self.df.columns]
        return self

    def rename_columns(self):
        logging.info(f"[Processor] Renaming columns")
        self.df = self.df.rename(columns={
                    'centralhub_detect_sig_detected':'centralhub_sig_detected',
                    'centralhub_detect_sig_detected_started':'centralhub_sig_detected_started',
                    'centralhub_detect_sig_detected_finished':'centralhub_sig_detected_finished',
                    'collectedprocessedobs_abpd_initial_active':'abpd_observer_initial_active',
                    'collectedprocessedobs_abpd_collectedreached_active':'abpd_observer_collectedreached_active',
                    'collectedprocessedobs_abpd_error_active':'abpd_observer_error_active',
                    'collectedprocessedobs_abps_initial_active':'abps_observer_initial_active',
                    'collectedprocessedobs_abps_collectedreached_active':'abps_observer_collectedreached_active',
                    'collectedprocessedobs_abps_error_active':'abps_observer_error_active',
                    'collectedprocessedobs_hr_initial_active':'heartrate_observer_initial_active',
                    'collectedprocessedobs_hr_collectedreached_active':'heartrate_observer_collectedreached_active',
                    'collectedprocessedobs_hr_error_active':'heartrate_observer_error_active',
                    'collectedprocessedobs_ox_initial_active':'oximeter_observer_initial_active',
                    'collectedprocessedobs_ox_collectedreached_active':'oximeter_observer_collectedreached_active',
                    'collectedprocessedobs_ox_error_active':'oximeter_observer_error_active',
                    'collectedprocessedobs_temp_initial_active':'temperature_observer_initial_active',
                    'collectedprocessedobs_temp_collectedreached_active':'temperature_observer_collectedreached_active',
                    'collectedprocessedobs_temp_error_active':'temperature_observer_error_active',
                    'abpd_datatransfer_sig_transfered' : 'abpd_sig_transfered',
                    'abpd_sig_transfered' : 'abpd_sig_transfered_old',
                    'abps_datatransfer_sig_transfered' : 'abps_sig_transfered',
                    'abps_sig_transfered' : 'abps_sig_transfered_old',
                    'heartRate_datatransfer_sig_transfered' : 'heartRate_sig_transfered',
                    'heartRate_sig_transfered' : 'heartRate_sig_transfered_old',
                    'oximeter_datatransfer_sig_transfered' : 'oximeter_sig_transfered',
                    'oximeter_sig_transfered' : 'oximeter_sig_transfered_old',
                    'temperature_sig_transfered' : 'temperature_sig_transfered_old',
                    'temperature_datatransfer_sig_transfered' : 'temperature_sig_transfered',
                })
        return self

    def breaking_execution_signals_for_all_sensors(self):
        logging.info(f"[Processor] Breaking executions signals")
        for sensor in self.config.SENSORS:
            self.df = (self.df
                    .pipe(creating_signal_start_finish_id, signal_col=f'{sensor}_sig_collected')
                    .pipe(creating_signal_start_finish_id, signal_col=f'{sensor}_sig_processed')
                    .pipe(creating_signal_start_finish_id, signal_col=f'{sensor}_sig_transfered')
                    .pipe(creating_signal_start_finish_id, signal_col=f'centralhub_sig_{sensor}_processed')
                    .pipe(creating_signal_available_id, signal_col=f'{sensor}_context')
                    .pipe(creating_signal_available_id, signal_col=f'{sensor}_sig_battery_on')
            )
        
        # CentralHub
        self.df = (self.df
                .pipe(creating_signal_start_finish_id, signal_col='centralhub_sig_processed')
                .pipe(creating_signal_start_finish_id, signal_col='centralhub_sig_detected')
                .pipe(creating_signal_available_id, signal_col='centralhub_battery_sig_battery_on')
                )
                    
        return self

    def breaking_observers_signals_for_all_sensors(self):
        logging.info(f"[Processor] Breaking state-transition signals for the observers")
        for sensor in self.config.SENSORS:
            self.df[f'{sensor}_observer_entered_initial_state'] = get_signal_change(self.df, f'{sensor}_observer_initial_active')
            self.df[f'{sensor}_observer_entered_collectedreached_state'] = get_signal_change(self.df, f'{sensor}_observer_collectedreached_active')
            self.df[f'{sensor}_observer_entered_error_state'] = get_signal_change(self.df, f'{sensor}_observer_error_active')
        return self
    
    def find_traces(self) -> pd.DataFrame:
        logging.info(f"[Processor] Setting traces for each sensor")
        for sensor, collected_col in zip(self.config.SENSORS, get_object_cols('sig_collected_started', self.config.SENSORS)):
            collected = np.array(
                                self.df.query(f'{collected_col} == 1').time.unique()
                            )

            idx = 0
            for min, max in zip(collected, collected + self.config.PROPERTY_TIME_LIMIT): #execution trace
                (self.df.loc[(self.df.time >= min)
                            &(self.df.time <= max),
                            f'{sensor}_trace_no']) = idx
                idx += 1
        return self

    def get_grouped_features(self, sensor:str):
        features = dict()
        features_dict = {
            'time': {"time":['min','max']},
            'contexts' : {f"{s}_context":'min' for s in self.config.SENSORS},
            'context_became_unavailable' : {f"{s}_context_became_unavailable":'max' for s in self.config.SENSORS},
            'measurement' : {f"{s}_measurement":['max','mean','std','min'] for s in self.config.SENSORS},
            'sig_battery_on' : {f"{s}_sig_battery_on":'min' for s in self.config.SENSORS},
            'battery_became_unavailable' : {f"{s}_sig_battery_on_became_unavailable":'max' for s in self.config.SENSORS},
            'battery_cell_soc' : {f"{s}_battery_cell_soc":['max','mean','std','min'] for s in self.config.SENSORS},
            'centralhub_battery_cell_soc' : {f"centralhub_battery_cell_soc":['max','mean','std','min']},
            'centralhub_detect_risk' : {f"centralhub_detect_risk":['max','mean','std','min']},
            'centralhub_sig_emergency': {'centralhub_sig_emergency': 'max'},
            'centralhub_battery_sig_battery_on_became_unavailable': {'centralhub_battery_sig_battery_on_became_unavailable':'max'},
            'observer_was_in_error': {f'{sensor}_observer_error_active': 'max'},
            'observer_entered_error_state': {f'{sensor}_observer_entered_error_state':'max'}
        }

        for values in features_dict.values():
            features.update(values)

        s = self.df.groupby(f'{sensor}_trace_no').agg(features)
        s.columns = [f"{col[0]}_{col[1]}" for col in s.columns]

        return s

    def save(self, seed:int):
        for sensor, df_trace in self.df_trace.items():
            filename = f'sensor_seed/{sensor}_seed{seed}.parquet'
            save_dataset(df_trace, os.path.join(*self.config.WRANGLE_PATH), filename)

    def preprocess_data(self, seed:int, save:bool=True):
        logging.info(f"[Processor] Preprocessing data for seed: {seed}")
        self = (self
                .read_dataframe(f'patient_{seed}.parquet')
                .rename_columns()
                .breaking_execution_signals_for_all_sensors()
                .breaking_observers_signals_for_all_sensors()
                .find_traces())
        
        for sensor in self.config.SENSORS:
            df_trace = (get_features_by_sensor(self.df, sensor, seed)
                        .join(self.get_grouped_features(sensor))
                        .reset_index()
                        )
            df_trace = df_trace.assign(
                                is_failure = df_trace.apply(failure_detect, args=(sensor,), axis=1),
                                is_property_violation = df_trace.apply(property_violation_detect, args=(sensor,), axis=1),
                                seed = seed
                            )
            self.df_trace[sensor] = df_trace

        if save:
            self.save(seed)
        
        return self

    def merge_dfs(self):
        for sensor in self.config.SENSORS:
            all_files = glob.glob(os.path.join(*self.config.WRANGLE_PATH, 'sensor_seed', f"{sensor}_seed*.parquet"))
            df = pd.concat((pd.read_parquet(f) for f in all_files), ignore_index=True)

            path = os.path.join(*self.config.WRANGLE_PATH, 'sensor_seed_merged')
            save_dataset(df, path, f"{sensor}.parquet")