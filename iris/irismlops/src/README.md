# Source Code (src) Folder

This folder contains the core scripts that drive the project, including data loading, preprocessing, model training, and other utilities.

## Files

- **data_loading.py**: Loads raw and processed datasets from the `data/` folder.
- **data_preprocessing.py**: Performs transformations on the raw datasets, such as cleaning and encoding.
- **model.py**: Defines the machine learning models used in the project.
- **train.py**: End-to-end script for running the entire data pipeline, from loading and preprocessing to model training and evaluation.

## Usage

Each script can be imported as a module or run independently, depending on the task.

For example, to load raw data:

```python
from src.data_loading import load_raw_data
data = load_raw_data('file.csv')
```

Refer to docs/src/ for more detailed documentation on each script.
