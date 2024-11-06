# Data Loading Script

This script (`src/data_loading.py`) is responsible for loading raw and processed datasets for use in notebooks and other scripts.

## Key Functions

- `load_raw_data()`: Loads data from the `data/raw/` directory.
- `load_processed_data()`: Loads data from the `data/processed/` directory.

### Usage

To use the data loading functions, import the script into your project or notebook:

```python
from src.data_loading import load_raw_data, load_processed_data

raw_data = load_raw_data('file_name.csv')
processed_data = load_processed_data('file_name.csv')
```

Ensure the file paths are correctly set relative to the data directory.
