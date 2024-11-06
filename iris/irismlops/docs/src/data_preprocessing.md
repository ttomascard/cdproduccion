# Data Preprocessing Script

This script (`src/data_preprocessing.py`) applies various transformations to raw datasets, preparing them for modeling.

## Key Functions

- `clean_data()`: Handles missing values, duplicates, and outliers.
- `transform_data()`: Encodes categorical variables, scales numerical features, etc.

### Usage

To use the preprocessing functions, import the script into your project or notebook:

```python
from src.data_preprocessing import clean_data, transform_data

cleaned_data = clean_data(raw_data)
transformed_data = transform_data(cleaned_data)
```
