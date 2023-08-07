# %%
import os
import time
import multiprocessing 
import pandas as pd
import numpy as np
from itertools import repeat
import matplotlib.pyplot as plt
from OMPython import OMCSessionZMQ
from OMPython import ModelicaSystem
import DyMat, DyMat.Export

omc = OMCSessionZMQ()

EXPERIMENT = 'experiment3'
MODELS_PATH = os.path.join('..','..','models')
DATA_PATH = os.path.join('..','..','data', EXPERIMENT)
MAIN_MODEL_NAME = 'BSN_fxd'
MAIN_MODEL_FILE = 'BSN_fxd.mo'
OTHER_MODELS_LIST = [os.path.join(MODELS_PATH, file) for file in os.listdir(MODELS_PATH) if file != MAIN_MODEL_FILE]

RESULT_COLUMNS = ['Abpd.measurement', 'Abpd.risk_pct', 'Abpd.sig_battery_on',
       'Abpd.sig_collected', 'Abpd.sig_processed', 'Abpd.sig_transfered',
       'Abpd.battery.cell.SOC', 'Abpd.context', 'Abps.measurement',
       'Abps.risk_pct', 'Abps.sig_battery_on', 'Abps.sig_collected',
       'Abps.sig_processed', 'Abps.sig_transfered', 'Abps.battery.cell.SOC',
       'Abps.context', 'HeartRate.measurement', 'HeartRate.risk_pct',
       'HeartRate.sig_battery_on', 'HeartRate.sig_collected',
       'HeartRate.sig_processed', 'HeartRate.sig_transfered',
       'HeartRate.battery.cell.SOC', 'HeartRate.context',
       'Oximeter.measurement', 'Oximeter.risk_pct', 'Oximeter.sig_battery_on',
       'Oximeter.sig_collected', 'Oximeter.sig_processed',
       'Oximeter.sig_transfered', 'Oximeter.battery.cell.SOC',
       'Oximeter.context', 'temperature.measurement', 'temperature.risk_pct',
       'temperature.sig_battery_on', 'temperature.sig_collected',
       'temperature.sig_processed', 'temperature.sig_transfered',
       'temperature.battery.cell.SOC', 'temperature.context',
       'centralHub.sig_processed',
       'centralHub.sig_abpd_processed',
       'centralHub.sig_abps_processed',
       'centralHub.sig_heartrate_processed',
       'centralHub.sig_oximeter_processed',
       'centralHub.sig_temperature_processed',
       'centralHub.sig_emergency',
       'centralHub.detect.patient_risk', 'centralHub.data_fuse.overall_risk',
       'centralHub.battery.cell.SOC', 'centralHub.battery.SIG_BATTERY_ON',
       'centralHub.detect.risk', 'centralHub.detect.sig_detected',
       'collectedProcessedObs_abpd.Initial.active',
       'collectedProcessedObs_abpd.collectedReached.active',
       'collectedProcessedObs_abpd.error.active',
       'collectedProcessedObs_abps.Initial.active',
       'collectedProcessedObs_abps.collectedReached.active',
       'collectedProcessedObs_abps.error.active',
       'collectedProcessedObs_hr.Initial.active',
       'collectedProcessedObs_hr.collectedReached.active',
       'collectedProcessedObs_hr.error.active',
       'collectedProcessedObs_ox.Initial.active',
       'collectedProcessedObs_ox.collectedReached.active',
       'collectedProcessedObs_ox.error.active',
       'collectedProcessedObs_temp.Initial.active',
       'collectedProcessedObs_temp.collectedReached.active',
       'collectedProcessedObs_temp.error.active']

def plot_sensors_data(df):
    _, ax = plt.subplots(2, 3, sharex=True, figsize=(15,10))

    ax[0,0].plot(df.index, df.abpd)
    ax[0,1].plot(df.index, df.abps)
    ax[0,2].plot(df.index, df.heartrate)
    ax[1,0].plot(df.index, df.oximeter)
    ax[1,1].plot(df.index, df.temperature)

    ax[0,0].set_title('Abpd')
    ax[0,1].set_title('Abps')
    ax[0,2].set_title('heartrate')
    ax[1,0].set_title('oximeter')
    ax[1,1].set_title('temperature')

    plt.show()

def set_new_parameters(mod, seed):
    """Sets new parameters for the Modelica model.
    It sets a parameter that randomizes how fast the battery runs out
    for each sensor, and chooses the file and the global seed that will
    be used in the simulation.

    Args:
        mod (_type_): ModelicaSystem model
        seed (_type_): integer value for replicability

    Returns:
        _type_: ModelicaSystem model with redefined parameters
    """
    np.random.seed(seed)

    sensors = ['Abpd','Abps','HeartRate','Oximeter','temperature']
    battery_gain = np.random.randint(low=10000, high=20000, size=len(sensors))
    
    for sensor, gain in zip(sensors, battery_gain):
        mod.setParameters(f'{sensor}.battery_gain={gain}')
    
    sensors_data = os.path.join(DATA_PATH, 'modelica_input',f'sensors_data_seed{seed}.txt')
    print(sensors_data)
    mod.setParameters([f"globalSeed.fixedSeed={seed}",f"sensor_measurements.fileName={sensors_data}"])
    return mod

def convert_mat_csv(input_file:str):
    output_file = os.path.join(DATA_PATH, 'modelica_output',f'{input_file}.csv')

    d = DyMat.DyMatFile(input_file+".mat")
    DyMat.Export.export('CSV', d, RESULT_COLUMNS, fileName=output_file)

def run_simulation_seed(mod, seed):
    print(seed)
    mod = set_new_parameters(mod, seed)
    result_file = f"BSN_res_seed{seed}"
    mod.simulate(resultfile=result_file+".mat")
    convert_mat_csv(result_file)
    os.remove(result_file+".mat")

def set_up_model():
    mod=ModelicaSystem(os.path.join(MODELS_PATH, MAIN_MODEL_FILE),MAIN_MODEL_NAME,["Modelica", *OTHER_MODELS_LIST])
    mod.buildModel()
    mod.setSimulationOptions(["startTime=0.2", "stopTime=100.0"])
    return mod

#%%
if __name__ == "__main__":
    start_time = time.time()
    mod = set_up_model()
    # with multiprocessing.Pool() as pool:
    #     pool.starmap(run_simulation_seed, zip(repeat(mod), range(5)))
    for seed in range(10):
        run_simulation_seed(mod, seed)
    print("--- %s seconds ---" % (time.time() - start_time))

    OUTPUT = os.path.join(DATA_PATH, 'modelica_output')
    for file in os.listdir(OUTPUT):
        print(file)
        if '.csv' not in file:
            continue
        df = pd.read_csv(os.path.join(OUTPUT,file))
        df.to_parquet(os.path.join(OUTPUT,file.replace('.csv','.parquet')))
        os.remove(os.path.join(OUTPUT,file))