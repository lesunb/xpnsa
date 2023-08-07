#%%
import os
import pandas as pd
import numpy as np

PROPERTY_TIME_LIMIT = 2

sensors = [
    'abpd',
    'abps',
    'heartrate',
    'oximeter',
    'temperature'
]

observers = [
    'collectedprocessedobs_abpd',
    'collectedprocessedobs_abps',
    'collectedprocessedobs_hr',
    'collectedprocessedobs_ox',
    'collectedprocessedobs_temp'
]

DATA_PATH = '../data/experiment1/modelica_output'

def get_object_cols(feature:str, list_objects:list = sensors) -> list:
    return [f'{col}_{feature}' for col in list_objects]
# %%
def read_dataframe(filename:str) -> pd.DataFrame:
    df = (pd
        .read_csv(os.path.join(DATA_PATH, filename))
        .drop_duplicates()
        .reset_index()
        .replace(-np.inf, 0) # first pass through moving average gives -inf
    )
    df.columns = [col.lower().replace('.','_') for col in df.columns]
    return df

def find_traces(df:pd.DataFrame, sensors:list) -> pd.DataFrame:
    for sensor, collected_col in zip(sensors, get_object_cols('sig_collected',sensors)):
        sig_collected = np.array(
                            df.query(f'{collected_col} == 1').time.unique()
                        )
        collected = np.array(list(set(sig_collected.round(1))))
        processed_ub = collected + PROPERTY_TIME_LIMIT

        idx = 0
        for min, max in zip(collected, collected + 2): #execution trace
            (df.loc[(df.time >= min)
                    &(df.time <= max),
                    f'{sensor}_trace_no']) = idx
            idx += 1
    return df

def feature_engineering(df: pd.DataFrame, sensors: list[str]):
    features = dict()
    features_dict = {
        'contexts' : {f"{sensor}_context":'min' for sensor in sensors},
        'measurement' : {f"{sensor}_measurement":['max','mean','std','min'] for sensor in sensors},
        'sig_battery_on' : {f"{sensor}_sig_battery_on":'min' for sensor in sensors},
        'sig_collected' : {f"{sensor}_sig_collected":'max' for sensor in sensors},
        'sig_processed' : {f"{sensor}_sig_processed":'max' for sensor in sensors},
        'sig_transfered' : {f"{sensor}_sig_transfered":'max' for sensor in sensors},
        'battery_cell_soc' : {f"{sensor}_battery_cell_soc":['max','mean','std','min'] for sensor in sensors},
        'centralhub_detect_sig_detected' : {f"centralhub_detect_sig_detected":'max'},
        'centralhub_battery_cell_soc' : {f"centralhub_battery_cell_soc":['max','mean','std','min']},
        'centralhub_detect_risk' : {f"centralhub_detect_risk":['max','mean','std','min']},
        'centralhub_sig_emergency': {'centralhub_sig_emergency': 'max'}
    }

    for values in features_dict.values():
        features.update(values)

    sensors_df = dict()

    for sensor in sensors:
        s = df.groupby(f'{sensor}_trace_no').agg(features)
        s.columns = [f"{col[0]}_{col[1]}" for col in s.columns]
        sensors_df[sensor] = s

    return sensors_df

def negative_selection(sensor:str, df: pd.DataFrame) -> pd.DataFrame:
    return (df
                .query(f'{sensor}_context_min > 0') # only traces in which the sensor was available
                .query(f'{sensor}_sig_collected_max == 1') # collected at some point
                .query(f'''{sensor}_sig_processed_max != 1 or \
                        {sensor}_sig_transfered_max != 1 or \
                        centralhub_detect_sig_detected_max != 1''')
                # .reset_index()
            )

def save_detectors_dataset(experiment_no:int, sensor:str, ns:pd.DataFrame, wrangle_path:str):
    filename = f'experiment{experiment_no}_{sensor}.csv'

    if not os.path.exists(os.path.join(wrangle_path, filename)):
        if not os.path.exists(wrangle_path):
            os.mkdir(wrangle_path)
        detectors = pd.DataFrame()
    else:
        detectors = pd.read_csv(os.path.join(wrangle_path, filename))
    
    detectors = pd.concat([detectors, ns])
    detectors.to_csv(os.path.join(wrangle_path, filename), index=False)        
# %%
def generate_features_order_based_trace(trace:pd.DataFrame, sensor:str):
    """Function that returns the times in which the signals were sent.
    Each signal is sent in a particular time. But, they must follow a certain
    order to be correct: first, the data is collected, then processed, then
    transfered, and finally detected. This function finds the time that
    a signal was sent and filters the dataset by removing the predecessor rows
    before checking for the next signal.

    Args:
        trace (pd.DataFrame): dataset with the execution trace. It must contain
            the columns that indicate if the signal was sent.
        sensor (str): name of the sensor

    Returns:
        tuple: tuple containing the timestamp and boolean features
    """
    collected_started = trace.query(f"{sensor}_collected_started == 1").time.values
    collected_finished = trace.query(f"{sensor}_collected_finished == 1").time.values

    if (len(collected_started) >= 1) and (len(collected_finished) >= 1):
        collected = 1
    else:
        collected = 0

    trace = trace.query(f"time >= @collected_finished[0]") # rows after collected
    processed_started = trace.query(f"{sensor}_processed_started == 1").time.values
    processed_finished = trace.query(f"{sensor}_processed_finished == 1").time.values
    
    if (len(processed_started) >= 1) and (len(processed_finished) >= 1):
        processed = 1
        trace = trace.query(f"time >= @processed_finished[0]") # rows after processed
    else:
        processed = 0
        processed_started = [np.nan]
        processed_finished = [np.nan]

    transfered_started = trace.query(f"{sensor}_transfered_started == 1").time.values
    transfered_finished = trace.query(f"{sensor}_transfered_finished == 1").time.values
    
    if (len(transfered_started) >= 1) or (len(transfered_finished) >= 1):
        transfered = 1
        trace = trace.query(f"time >= @transfered_finished[0]") # rows after transfered
    else:
        transfered = 0
        transfered_started = [np.nan]
        transfered_finished = [np.nan]
    
    detected_started = trace.query(f"centralhub_detect_detected_started == 1").time.values
    detected_finished = trace.query(f"centralhub_detect_detected_finished == 1").time.values

    if (len(detected_started) >= 1) or (len(detected_finished) >= 1):
        detected = 1
    else:
        detected = 0
        detected_started = [np.nan]
        detected_finished = [np.nan]
    print(
            collected,
            collected_started[0], 
            collected_finished[0],
            processed,
            processed_started[0], 
            processed_finished[0],
            transfered,
            transfered_started[0],
            transfered_finished[0],
            detected,
            detected_started[0],
            detected_finished[0],
            )
    return (
            collected,
            collected_started[0], 
            collected_finished[0],
            processed,
            processed_started[0], 
            processed_finished[0],
            transfered,
            transfered_started[0],
            transfered_finished[0],
            detected,
            detected_started[0],
            detected_finished[0],
            )

def generate_features_order_based(df: pd.DataFrame, sensor: str):
    """Wrapper for the generate_features_order_based_trace
    It goes through each trace identified in the dataset and calls
    the function.

    Args:
        df (pd.DataFrame): dataset with traces of execution
        sensor (str): name of the sensor to which the operations will
            be executed

    Returns:
        pd.DataFrame: Dataframe with final features
    """
    result = {}
    for trace_no, trace in df.groupby(f"{sensor}_trace_no", dropna=True):
        result.update({trace_no: generate_features_order_based_trace(trace, sensor)})
    result = pd.DataFrame(result).T
    result.index.name = f'{sensor}_trace_no'
    result.columns = [
        f'{sensor}_collected', 
        f'{sensor}_collected_started', 
        f'{sensor}_collected_finished',
        f'{sensor}_processed', 
        f'{sensor}_processed_started', 
        f'{sensor}_processed_finished',
        f'{sensor}_transfered',
        f'{sensor}_transfered_started',
        f'{sensor}_transfered_finished',
        f'centralhub_detected',
        f'centralhub_detected_started',
        f'centralhub_detected_finished',
    ]
    return result

