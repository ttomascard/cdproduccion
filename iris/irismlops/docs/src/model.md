# Model Script

This script (`src/model.py`) defines the machine learning models used in this project.

## Key Functions

- `train_model()`: Trains a machine learning model based on input data.
- `evaluate_model()`: Evaluates the model using test data and returns performance metrics.

### Usage

To train and evaluate a model, import the script into your project or notebook:

```python
from src.model import train_model, evaluate_model

model = train_model(processed_data)
metrics = evaluate_model(model, test_data)
```

Ensure that the processed_data and test_data are loaded and prepared before running the model.
