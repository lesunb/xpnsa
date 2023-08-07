import os
import datetime
import logging
from matplotlib import docstring
import yaml
from dataclasses import dataclass
from typing import List, Dict

def make_dc(d: dict, name:str='d_dataclass'):
    """Dynamic creation of a dataclass, based on a dictionary.
    
    The Dataclass need the data types of each attribute to be specified,
    finding them throught the class variable __annotations__, which is a dictionary
    that maps attributes to types. Therefore, this function creates this variable
    based on one of the function parameters.

    Args:
        d (dict): Dictionary on which the class is based.
                    the keys must be the names of the attributes and the values the
                    elements with the desired type.
        name (str, optional): Name of the class to be created. Defaults to 'd_dataclass'.

    Returns:
        _type_: created class.
    """
    @dataclass
    class Wrapped:
        __annotations__ = {k: type(v) for k, v in d.items()}
        
    Wrapped.__qualname__ = Wrapped.__name__ = name

    return Wrapped

def get_config(config_file:str):
    """Reads a configuration file.

    Args:
        config_file (str): Name of the yaml configuration file stored in the config folder.
    Returns:
        _type_: The object of a dataclass generated automatically based on the read file.
    """
    config_path = f"..\\files\\config\\{config_file}.yaml"

    with open(config_path, "r") as f:
        yaml_config = yaml.safe_load(f)
    Config = make_dc(yaml_config, name=config_file)
    conf = Config(**yaml_config)

    return conf

def setup_logger(process):
    if not os.path.exists("../files/log/"):
        os.makedirs("../files/log")

    filename="../files/log/log_" + process + "_{:%d%m%Y_%H%M}.log".format(datetime.datetime.now())

    logging.basicConfig(
        format="[%(asctime)s][%(levelname)s] %(message)s",
        level=logging.DEBUG,
        datefmt="%m/%d/%Y %H:%M:%S",
        filename=filename,
    )

    return filename