#%%
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split, StratifiedShuffleSplit
from experiment.markov_chain import generate_sensors_data, convert_file_to_modelica_input

seed = 42
rng = np.random.default_rng(seed)
sample_size = 100
how_many = 1000
categories = {
        1:'CardiacSurgeryUnit',
        2:'CoronaryCareUnit',
        3:'MedicalICU',
        4:'SurgicalICU'
    }
OUTPUT_PATH = f"..\\data\\experiment4"

patient_table = pd.DataFrame()

for patient_id in range(how_many):
    category = categories[rng.choice(list(categories.keys()))]
    config_path = f"byICU\\{category}"

    sensors_data = generate_sensors_data(sample_size, patient_id, rng, config_path)
    sensors_data.to_csv(f"{OUTPUT_PATH}\\dataframe\\patient_{patient_id}.csv")
    convert_file_to_modelica_input(sensors_data, f"patient_{patient_id}", OUTPUT_PATH)
    
    # keeping track of the generated patients
    patient_table = pd.concat([patient_table, pd.DataFrame([[patient_id, category]], columns=['patient_id','category'])])

#%%
patient_table.reset_index(drop=True, inplace=True)
train, test = train_test_split(patient_table, test_size=0.25, stratify=patient_table['category']) 
train.to_parquet('../data/experiment4/train.parquet')
test.to_parquet('../data/experiment4/test.parquet')
# %%