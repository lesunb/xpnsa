# Explainability for Property Violations in Cyber-Physical Systems: An Immune-inspired Approach

## Overview

This repository contains the code implementation for the paper titled "Explainability for Property Violations in Cyber-Physical Systems: An Immune-inspired Approach." The goal of the project is to provide an immune-inspired approach to enhance the explainability of property violations in cyber-physical systems.


## Table of Contents

- [Abstract](#introduction)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Contact](#contact)

## Abstract

Complex relations between cybernetic and physical components of a cyber-physical system (CPS) in tandem with continuous environment changes represent a challenge to engineering robust CPSs. To help engineers determine the cause of violations, there is a need for a systematic approach that helps understanding the system behaviors that lead to critical failures of the CPS. In this work, we present a methodology that identifies and isolates crucial anomalous behaviors that can not only hamper the system but also are often challenging to capture while engineering a CPS. 

## Getting Started

### Prerequisites


```bash
$ pip install -r requirements.txt
```

## Usage
Following the paper's structure, the code was split into files inside src/ and numbered for convenience.

### Before the method
- **1.app_create_experiment_markov.py**: responsible for collecting the patient's vital signs based on the markov chain developed in [this Github repo](https://github.com/rdinizcal/markov-sensors/tree/1.0.0). A csv with the readings is stored for the next steps.

### Step 1: Feature Engineering
- **2.data_pipeline.py**: Runs the simulations in OpenModelica based on the readings. The results are parsed and the features are created.
- **3. Temperature_sanity_check.ipynb**: Checks the sanity of the engineered features.
- **4. temperature_eda.ipynb**: Explores the dataset with the engineered features. Features are ranked based on the correlation with the label and low correlated ones are discarded.

### Step 2: Negative Selection
- **5. Negative Selection.ipynb**: Execution of the NSA algorithm to generate the detectors

### Step 3: Detector's Analysis
- **6. temperature_ns_result.ipynb**: Analysis of the detectors, generation of the clusters and plots.

## Contact
If there are any questions regarding the overall methodology or how to run the experiments, please feel free to contact us at:
- jp.araujo@hu-berlin.de
