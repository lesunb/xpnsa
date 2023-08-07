import os
import pandas as pd
import numpy as np
import logging

def get_signal_change(df:pd.DataFrame, column:str):
    if df.filter([column]).shape[1] == 0:
        logging.error(f"[dfHandler] Name Error: Column {column} not present in dataframe")
        raise NameError(f"Column {column} not present in dataframe")

    return df.filter([column]).transform(pd.Series.diff)

def creating_signal_available_id(df:pd.DataFrame, signal_col:str):
    signal_changed = get_signal_change(df, signal_col)
    df[f'{signal_col}_became_available'] = (signal_changed == 1).astype(int)
    df[f'{signal_col}_became_unavailable'] = (signal_changed == -1).astype(int)
    return df

def creating_signal_start_finish_id(df:pd.DataFrame, signal_col:str):    
    signal_changed = get_signal_change(df, signal_col)
    df[f'{signal_col}_started'] = (signal_changed == 1).astype(int)
    df[f'{signal_col}_finished'] = (signal_changed == -1).astype(int)
    return df

def get_object_cols(feature:str, list_objects:list) -> list:
    return [f'{col}_{feature}' for col in list_objects]

def partial_trace_parse(trace, sensor, sig, result, trace_initial_time, source=None):
    if source is None:
        source = sensor
    try:
        started = trace.query(f"{source}_sig_{sig}_started == 1").time.values
        finished = (trace
                        .query(f"time >= @started[0]")
                        .query(f"{source}_sig_{sig}_finished == 1")).time.values
    except:
        result[f'{source}_{sig}'] = 0
        return False, result
    
    if len(finished) < 1: #did not complete processing
        result[f'{source}_{sig}'] = 0
        return False, result

    result[f'{source}_{sig}'] = 1
    result[f'{source}_{sig}_started'] = started[0]
    result[f'{source}_{sig}_started_relative'] = started[0] - trace_initial_time
    result[f'{source}_{sig}_finished'] = finished[0]
    result[f'{source}_{sig}_finished_relative'] = finished[0] - trace_initial_time

    event_trace = (trace
                        .query(f"time >= @started[0]")
                        .query(f"time <= @finished[0]")
                        )

    result[f'{source}_{sig}_duration'] = finished[0] - started[0]
    
    if source != sensor:
        sig = "_".join([source, sig])
        result[f'{source}_battery_became_unavailable_during_{sig}'] = event_trace[f'{source}_battery_sig_battery_on_became_unavailable'].max()

    result[f'{sensor}_battery_became_unavailable_during_{sig}'] = event_trace[f'{sensor}_sig_battery_on_became_unavailable'].max()
    result[f'{sensor}_error_reached_during_{sig}'] = event_trace[f'{sensor}_observer_entered_error_state'].max()
    result[f'{sensor}_became_unavailable_during_{sig}'] = event_trace[f'{sensor}_context_became_unavailable'].max()
    result[f'{sensor}_was_available_during_{sig}'] = event_trace[f'{sensor}_context'].min()

    if source != sensor:
        return True, result

    # battery decrease during signal
    soc_started = trace.query("time == @started[0]")[f'{sensor}_battery_cell_soc'].values[0]
    soc_finished = trace.query("time == @finished[0]")[f'{sensor}_battery_cell_soc'].values[0]
    result[f'{sensor}_battery_decrease_during_{sig}'] = soc_started - soc_finished
    return True, result

def generate_features_order_based_trace(trace:pd.DataFrame, sensor:str, trace_no:int):
    result = {
        f'{sensor}_collected':np.nan, 
        f'{sensor}_collected_started':np.nan, 
        f'{sensor}_collected_started_relative':np.nan, 
        f'{sensor}_collected_finished':np.nan,
        f'{sensor}_collected_finished_relative':np.nan,
        f'{sensor}_battery_became_unavailable_during_collected':np.nan,
        f'{sensor}_error_reached_during_collected':np.nan,
        f'{sensor}_became_unavailable_during_collected':np.nan,
        f'{sensor}_was_available_during_collected':np.nan,
        f'{sensor}_collected_duration':np.nan,
        f'{sensor}_battery_decrease_during_collected':np.nan,
        f'{sensor}_processed':np.nan, 
        f'{sensor}_processed_started':np.nan, 
        f'{sensor}_processed_started_relative':np.nan, 
        f'{sensor}_processed_finished':np.nan,
        f'{sensor}_processed_finished_relative':np.nan,
        f'{sensor}_battery_became_unavailable_during_processed':np.nan,
        f'{sensor}_error_reached_during_processed':np.nan,
        f'{sensor}_became_unavailable_during_processed':np.nan,
        f'{sensor}_was_available_during_processed':np.nan,
        f'{sensor}_processed_duration':np.nan,
        f'{sensor}_battery_decrease_during_processed':np.nan,
        f'{sensor}_transfered':np.nan,
        f'{sensor}_transfered_started':np.nan,
        f'{sensor}_transfered_started_relative':np.nan,
        f'{sensor}_transfered_finished':np.nan,
        f'{sensor}_transfered_finished_relative':np.nan,
        f'{sensor}_battery_became_unavailable_during_transfered':np.nan,
        f'{sensor}_error_reached_during_transfered':np.nan,
        f'{sensor}_became_unavailable_during_transfered':np.nan,
        f'{sensor}_was_available_during_transfered':np.nan,
        f'{sensor}_transfered_duration':np.nan,
        f'{sensor}_battery_decrease_during_transfered':np.nan,
        f'centralhub_{sensor}_processed': np.nan,
        f'centralhub_{sensor}_processed_started': np.nan,
        f'centralhub_{sensor}_processed_started_relative': np.nan,
        f'centralhub_{sensor}_processed_finished': np.nan,
        f'centralhub_{sensor}_processed_finished_relative': np.nan,
        f'centralhub_{sensor}_processed_duration': np.nan,
        f'{sensor}_battery_became_unavailable_during_centralhub_processed': np.nan,
        f'{sensor}_error_reached_during_centralhub_processed': np.nan,
        f'{sensor}_became_unavailable_during_centralhub_processed': np.nan,
        f'{sensor}_was_available_during_centralhub_processed': np.nan,
        f'centralhub_battery_became_unavailable_during_centralhub_processed': np.nan,
        f'centralhub_detected':np.nan,
        f'centralhub_detected_started':np.nan,
        f'centralhub_detected_started_relative':np.nan,
        f'centralhub_detected_finished':np.nan,
        f'centralhub_detected_finished_relative':np.nan,
        f'centralhub_detected_duration':np.nan, 
        f'{sensor}_battery_became_unavailable_during_centralhub_detected':np.nan,
        f'{sensor}_error_reached_during_centralhub_detected':np.nan,
        f'{sensor}_became_unavailable_during_centralhub_detected':np.nan,
        f'{sensor}_was_available_during_centralhub_detected':np.nan,
        f'centralhub_battery_became_unavailable_during_centralhub_detected': np.nan,
        f'{sensor}_battery_decrease_during_trace': np.nan,
        'centralhub_battery_decrease_during_trace': np.nan,
    }

    trace_initial_time = trace.head(1).time.values[0]

    # battery decrease during trace
    soc_started = trace.head(1)[f'{sensor}_battery_cell_soc'].values[0]
    soc_finished = trace.tail(1)[f'{sensor}_battery_cell_soc'].values[0]
    result[f'{sensor}_battery_decrease_during_trace'] = soc_started - soc_finished

    ch_soc_started = trace.head(1)[f'centralhub_battery_cell_soc'].values[0]
    ch_soc_finished = trace.tail(1)[f'centralhub_battery_cell_soc'].values[0]
    result[f'centralhub_battery_decrease_during_trace'] = ch_soc_started - ch_soc_finished

    collected_happened, result = partial_trace_parse(trace, sensor, 'collected', result, trace_initial_time)
    collected_finished = result[f'{sensor}_collected_finished']
    if not collected_happened:
        collected_finished = trace.head(1).time.values[0]
    
    trace = trace[trace.time >= collected_finished] # rows after processed
    processed_happened, result = partial_trace_parse(trace, sensor, 'processed', result, trace_initial_time)
    processed_finished = result[f'{sensor}_processed_finished']
    if not processed_happened:
        processed_finished = collected_finished
    
    trace = trace[trace.time >= processed_finished] # rows after processed
    transfered_happened, result = partial_trace_parse(trace, sensor, 'transfered', result, trace_initial_time)
    transfered_finished = result[f'{sensor}_transfered_finished']
    if not transfered_happened:
        transfered_finished = processed_finished

    trace = trace[trace.time >= transfered_finished] # rows after processed
    ch_processed_happened, result = partial_trace_parse(trace, sensor, f'{sensor}_processed', result, trace_initial_time, source='centralhub')
    # ch_processed = result['centralhub_detected_finished']
    # if not ch_processed_happened:
    #     ch_processed = transfered_finished

    # trace = trace[trace.time >= ch_processed] # rows after processed
    # _, result = partial_trace_parse(trace, sensor, 'detected', result, trace_initial_time, source='centralhub')

    return pd.DataFrame([result], index=[trace_no])

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
    result_df = pd.DataFrame()
    for trace_no, trace in df.groupby(f"{sensor}_trace_no", dropna=True):
        result_df = pd.concat([result_df, generate_features_order_based_trace(trace, sensor, trace_no)])
    result_df.index.name = f'{sensor}_trace_no'
    
    return result_df

def get_features_by_sensor(df, sensor, seed):
    return (generate_features_order_based(df, sensor=sensor))

def failure_detect(row, sensor):
    if (row[f'{sensor}_context_min'] == 1) and (row[f'{sensor}_collected'] == 1):
        if (
            ( # something went wrong
                (row[f'{sensor}_processed'] != 1) or
                (row[f'{sensor}_transfered'] != 1) or
                (row[f'centralhub_{sensor}_processed'] != 1)
            ) 
            # and
            # ( # system didn't notice
            #     (row[f"{sensor}_observer_entered_error_state_max"]  != 1)
            # )
        ):
            return 1
    return 0

def property_violation_detect(row, sensor):
    if (row[f'{sensor}_collected'] == 1):
        if (
            ( # something went wrong
               (row[f'centralhub_{sensor}_processed'] != 1)
            ) 
        ):
            return 1
    return 0

def save_dataset(df:pd.DataFrame, path:str, filename:str):
    if not os.path.exists(os.path.join(path, filename)):
        if not os.path.exists(path):
            os.mkdir(path)
    df.to_parquet(os.path.join(path, filename), index=False)