#%%
import os
import sys
import logging
import multiprocessing
import pandas as pd
from OpenModelica import OMSimulator
from preprocessing import Processor
from config import get_config, setup_logger
from preprocessing import dfhandler

def run_batch(seed):
    print(seed)
    Processor().preprocess_data(seed)

# Join dfs
def save_train_test(train_or_test:str='train'):
    p = Processor()
    files = os.listdir(os.path.join(*p.config.WRANGLE_PATH, 'sensor_seed'))

    patients_df = pd.read_parquet(os.path.join(config.DATA_PATH, "experiment4", f"{train_or_test}.parquet"))

    for sensor in p.config.SENSORS:
        print(sensor)
        matching_files = []
        for file in files:
            if any(sensor + f'_seed{column_value}.parquet' in file for column_value in patients_df.patient_id):
                matching_files.append(file)
        df = pd.concat((pd.read_parquet(os.path.join(*p.config.WRANGLE_PATH, 'sensor_seed',f)) for f in matching_files), ignore_index=True)

        path = os.path.join(*p.config.WRANGLE_PATH, 'sensor_seed_merged', f'{train_or_test}')
        dfhandler.save_dataset(df, path, f"{sensor}.parquet")

if __name__ == '__main__':
    os.chdir(sys.path[0])
    setup_logger('data_pipeline')

    logging.info("Starting: Data Preprocessing Pipeline")
    logging.info(f"Current path: {os.getcwd()}")

    config = get_config('config')
    how_many = 1000
#%%

    sim = (OMSimulator()
            .set_up_model()
            .run_batch_simulations(how_many=how_many)
            .clean_up()
        )


# #%%

    pool = multiprocessing.Pool()
    pool.map(run_batch, range(how_many))
    pool.close()

#%%
    save_train_test('train')
    save_train_test('test')

# %%
