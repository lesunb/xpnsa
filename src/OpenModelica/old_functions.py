#%%
import pandas as pd
import os
from OMPython import OMCSessionZMQ
omc = OMCSessionZMQ()
# %%
omc.sendExpression("loadModel(Modelica)")
for file in os.listdir('../../models'):
    omc.sendExpression(f"loadFile(\"../../models/{file}\")")
#%%
omc.sendExpression("instantiateModel(BSN)")
# %%
omc.sendExpression("simulate(BSN, startTime=0.02, stopTime=20.0, outputFormat=\"csv\")")
# %%
df = pd.read_csv('BSN_res.csv')
# %%
from OMPython import OMCSessionZMQ
from OMPython import ModelicaSystem
omc = OMCSessionZMQ()
MODELS_PATH = os.path.join('..','..','models')
other_models = [os.path.join(MODELS_PATH, file) for file in os.listdir(MODELS_PATH) if file !='BSN.mo']
mod=ModelicaSystem(os.path.join(MODELS_PATH, "BSN.mo"),"BSN",["Modelica", *other_models])
mod.buildModel()
mod.setSimulationOptions(["startTime=0.2", "stopTime=100.0"])
# %%
seed = 22
for seed in [22,33,44]:
    sensors_data = f'C:/Users/JoaoPauloAraujo/Documents/Mestrado/Artigos/AIS/code/BSN_Modelica/v2/data/experiment2/modelica_input/sensors_data_seed{seed}.txt'
    mod.setParameters([f"globalSeed.fixedSeed={seed}",f"sensor_measurements.fileName={sensors_data}"])
    mod.simulate(resultfile=f"BSN_res_seed{seed}.mat")
# %%
import DyMat, DyMat.Export

cols = ['Abpd.measurement', 'Abpd.risk_pct', 'Abpd.sig_battery_on',
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
       'centralHub.sig_processed', 'centralHub.sig_emergency',
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


d = DyMat.DyMatFile("BSN_res.mat")
# DyMat.Export.export('CSV', d, d.names())
#%%
DyMat.Export.export('CSV', d, cols)
# %%
import pandas as pd
df = pd.read_csv("BSN_res.mat.csv")
# %%

# %%
