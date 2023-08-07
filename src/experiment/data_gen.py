import numpy as np
import pandas as pd
import numpy as np
from typing import Callable
import matplotlib.pyplot as plt

from .range import Range, convert_new_range

class DataGenerator():  
    def plot_time_series(self, time, values, label, ax) -> None:
        plt.figure(figsize=(10,6))
        plt.plot(time, values, axis=ax)
        plt.xlabel("Time", fontsize=20)
        plt.ylabel("Value", fontsize=20)
        plt.title(label, fontsize=20)
        plt.grid(True)

    def create_data_range(self, start, end, freq) -> pd.date_range:
        return pd.date_range(start=start, end=end, freq=freq)

    def _convert_range(self, values, old_range, new_range):
        return np.array(list(map(lambda x: convert_new_range(x, old_range, new_range), values)))

    def create_gradual_change(self, size:int, crescent:bool = True, new_range:Range = None, seed:int=-1) -> list:
        if seed >= 0:
            np.random.seed(seed)
        index = np.arange(size)
        values = list(np.where(index < 10, index, (index-9)**2))
        noise = np.random.randn(size)*1000
        values += noise
        
        if new_range:
            old_range = Range(values.min(), values.max())
            values = self._convert_range(values, old_range, new_range)

        if not crescent:
            return values[::-1]
        return values

    def create_stable_data(self, size:int, rang:Range, seed:int=-1) -> list:
        if seed >= 0:
            np.random.seed(seed)
        return np.random.uniform(rang.lb, rang.ub, size)

    def get_function_by_cod(self, cod:int) -> Callable:
        return  {
                    0: 'stable',
                    1: 'decrescent',
                    2: 'crescent'
                }[cod]
