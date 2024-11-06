# Data Folder

This folder contains all the datasets used in the project, organized into three subfolders: `raw`, `processed`, and `models`.

## Subfolders

- **raw/**: Contains unprocessed, original datasets.
- **processed/**: Stores cleaned and transformed datasets ready for analysis and model training.
- **models/**: Contains trained machine learning models, saved in formats like `.pkl` or `.joblib`.

## Usage

- **raw data** should never be altered and serves as the source for preprocessing.
- **processed data** is generated through the preprocessing pipeline and should be used for all analysis and modeling tasks.
- **models** can be loaded for inference or evaluation, using scripts from the `src` directory.

Refer to the documentation in `docs/data` for more detailed information about each subfolder.
