#%%
from  app_process_data import *
from data_process import *



NUMERIC_COLUMNS = [
    'abpd_measurement',
    'abpd_risk_pct',
    'abpd_battery_cell_soc',
    'abps_measurement',
    'abps_risk_pct',
    'abps_battery_cell_soc',
    'heartrate_measurement',
    'heartrate_risk_pct',
    'heartrate_battery_cell_soc',
    'oximeter_measurement',
    'oximeter_risk_pct',
    'oximeter_battery_cell_soc',
    'temperature_measurement',
    'temperature_risk_pct',
    'temperature_battery_cell_soc',
    'centralhub_detect_patient_risk', 
    'centralhub_data_fuse_overall_risk',
    'centralhub_battery_cell_soc', 
    'centralhub_detect_risk', 
]

SIGNAL_COLUMNS = [
    # 'index', 
    # 'time',  
    'abpd_sig_battery_on', 
    'abpd_sig_collected', 
    'abpd_sig_processed',
    'abpd_sig_transfered',  
    'abpd_context',  
    'abps_sig_battery_on',
    'abps_sig_collected', 
    'abps_sig_processed', 
    'abps_sig_transfered', 
    'abps_context',  
    'heartrate_sig_battery_on',
    'heartrate_sig_collected', 
    'heartrate_sig_processed',
    'heartrate_sig_transfered', 
    'heartrate_context',  
    'oximeter_sig_battery_on', 
    'oximeter_sig_collected',
    'oximeter_sig_processed', 
    'oximeter_sig_transfered', 
    'oximeter_context', 
    'temperature_sig_battery_on', 
    'temperature_sig_collected',
    'temperature_sig_processed', 
    'temperature_sig_transfered', 
    'temperature_context',
    'centralhub_sig_processed', 
    'centralhub_sig_emergency',
    'centralhub_battery_sig_battery_on',
    'centralhub_detect_sig_detected',
    'collectedprocessedobs_abpd_initial_active',
    'collectedprocessedobs_abpd_collectedreached_active',
    'collectedprocessedobs_abpd_error_active',
    'collectedprocessedobs_abps_initial_active',
    'collectedprocessedobs_abps_collectedreached_active',
    'collectedprocessedobs_abps_error_active',
    'collectedprocessedobs_hr_initial_active',
    'collectedprocessedobs_hr_collectedreached_active',
    'collectedprocessedobs_hr_error_active',
    'collectedprocessedobs_ox_initial_active',
    'collectedprocessedobs_ox_collectedreached_active',
    'collectedprocessedobs_ox_error_active',
    'collectedprocessedobs_temp_initial_active',
    'collectedprocessedobs_temp_collectedreached_active',
    'collectedprocessedobs_temp_error_active',
    'oximeter_sig_collected_started', 
    'oximeter_sig_collected_finished'
       ]

DATA_PATH = '..\data\experiment4\modelica_output'
WRANGLE_PATH = os.path.join(DATA_PATH, '..\wrangle')
# experiment_no = 1

def silent_failure_detect(row, sensor):
    if (row[f'{sensor}_context_min'] == 1) and (row[f'{sensor}_collected'] == 1):
        if (
            ( # something went wrong
                (row[f'{sensor}_processed'] != 1) or
                (row[f'{sensor}_transfered'] != 1) or
                (row[f'centralhub_{sensor}_processed'] != 1)
            ) 
            and
            ( # system didn't notice
                (row[f"{sensor}_observer_entered_error_state_max"]  != 1)
            )
        ):
            return 1
    return 0

def property_violation_detect(row, sensor):
    if (row[f'{sensor}_collected'] == 1):
        if (
            ( # something went wrong
                # (row[f'{sensor}_processed'] != 1) or
                # (row[f'{sensor}_transfered'] != 1) or
                (row[f'centralhub_{sensor}_processed'] != 1)
            ) 
            # and
            # ( # system noticed
            #     (row[f"{sensor}_observer_entered_error_state_max"]  == 1)
            # )
        ):
            return 1
    return 0

def breaking_execution_signals_for_all_sensors(df, sensors):
    for sensor in sensors:
        print(sensor)
        df = (df
                .pipe(creating_signal_start_finish_id, signal_col=f'{sensor}_sig_collected')
                .pipe(creating_signal_start_finish_id, signal_col=f'{sensor}_sig_processed')
                .pipe(creating_signal_start_finish_id, signal_col=f'{sensor}_sig_transfered')
                .pipe(creating_signal_start_finish_id, signal_col=f'centralhub_sig_{sensor}_processed')
                .pipe(creating_signal_available_id, signal_col=f'{sensor}_context')
                .pipe(creating_signal_available_id, signal_col=f'{sensor}_sig_battery_on')
        )
    
    # CentralHub
    df = (df
            .pipe(creating_signal_start_finish_id, signal_col='centralhub_sig_processed')
            .pipe(creating_signal_start_finish_id, signal_col='centralhub_sig_detected')
            .pipe(creating_signal_available_id, signal_col='centralhub_battery_sig_battery_on')
            )
                
    return df

def creating_signal_start_finish_id(df:pd.DataFrame, signal_col:str):
    print(signal_col)
    signal_changed = get_signal_change(df, signal_col)
    df[f'{signal_col}_started'] = (signal_changed == 1).astype(int)
    df[f'{signal_col}_finished'] = (signal_changed == -1).astype(int)
    return df

def breaking_observers_signals_for_all_sensors(df, sensors):
    for sensor in sensors:
        df[f'{sensor}_observer_entered_initial_state'] = get_signal_change(df, f'{sensor}_observer_initial_active')
        df[f'{sensor}_observer_entered_collectedreached_state'] = get_signal_change(df, f'{sensor}_observer_collectedreached_active')
        df[f'{sensor}_observer_entered_error_state'] = get_signal_change(df, f'{sensor}_observer_error_active')
    return df

def generate_features_order_based_for_all_sensors(df, sensors):
    for sensor in sensors:
        generate_features_order_based(df, sensor)

def rename_columns(df):
    return df.rename(columns={
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
                'collectedprocessedobs_temp_error_active':'temperature_observer_error_active'
            })

def get_features_by_sensor(df, sensor, seed):
    df_trace = (generate_features_order_based(df, sensor=sensor)
                .join(get_grouped_features(df, sensor))
                .reset_index()
                )

    df_trace['is_silent_failure'] = df_trace.apply(silent_failure_detect, args=(sensor,), axis=1)
    df_trace['is_property_violation'] = df_trace.apply(property_violation_detect, args=(sensor,), axis=1)
    
    df_trace['seed'] = seed
    return df_trace

def preprocess_data(seed, sensors=sensors):
    return (read_dataframe(f'patient_{seed}.parquet')
            .pipe(rename_columns)
            .pipe(breaking_execution_signals_for_all_sensors, sensors=sensors)
            .pipe(breaking_observers_signals_for_all_sensors, sensors=sensors)
            .pipe(find_traces, sensors = sensors)
        )

def run_preprocessing_pipeline(seed, experiment_no=2, sensors=sensors):
    # print(seed, experiment_no, sensors)
    df = preprocess_data(seed, sensors=sensors)

    for sensor in sensors:
        df_trace = get_features_by_sensor(df, sensor, seed)
        save_detectors_dataset(experiment_no, sensor, df_trace, WRANGLE_PATH, seed)
#%%
if __name__ == "__main__":
    start_time = time.time()
    print(PROPERTY_TIME_LIMIT)
    # pool = multiprocessing.Pool()
    # pool.map(run_preprocessing_pipeline, range(10))
    # pool.close()
    # print("--- %s seconds ---" % (time.time() - start_time))

    for i in range(30):
        print(i)
        run_preprocessing_pipeline(i)
    
    # for sensor in sensors:
    #     all_files = glob.glob(os.path.join(WRANGLE_PATH, 'sensor_seed', f"{sensor}_seed*.parquet"))
    #     df = pd.concat((pd.read_parquet(f) for f in all_files), ignore_index=True)

    #     path = os.path.join(WRANGLE_PATH, 'sensor_seed_merged')
    #     if not os.path.exists(path):
    #         os.mkdir(path)

    #     df.to_parquet(os.path.join(path, f"{sensor}.parquet"), index=False)
# # %%
# import numpy as np
# for seed in np.random.randint(low=0, high=250, size=3):
#     print(seed)
#     run_preprocessing_pipeline(seed, experiment_no=3, sensors=sensors)

#%%
    # for seed in range(10):
    #     for sensor in sensors:
    #         f = os.path.join(WRANGLE_PATH, 'sensor_seed', f"{sensor}_seed{seed}.parquet")
    #         df = pd.read_parquet(f)
    #         df.seed = seed
    #         df.to_parquet(f)
    # %%
    # for sensor in sensors:
    #     all_files = glob.glob(os.path.join(WRANGLE_PATH, 'sensor_seed', f"{sensor}_seed*.parquet"))
    #     df = pd.concat((pd.read_parquet(f) for f in all_files), ignore_index=True)

    #     path = os.path.join(WRANGLE_PATH, 'sensor_seed_merged')
    #     if not os.path.exists(path):
    #         os.mkdir(path)

    #     df.to_parquet(os.path.join(path, f"{sensor}.parquet"), index=False)
    # %%
