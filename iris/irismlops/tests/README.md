# Tests Folder

This folder contains unit tests for the scripts in the `src/` folder. These tests ensure the correctness and reliability of the data loading, preprocessing, and model training functions.

## Files

- **test_data_loading.py**: Tests the functions in `data_loading.py`, ensuring that data is correctly loaded from the `data/` folder.
- **test_model.py**: Tests the functions in `model.py`, including model training and evaluation.

## Usage

To run all tests, use the following command:

```bash
pytest tests/
```

Alternatively, run tests for a specific script:

```bash
pytest tests/test_data_loading.py
````

Refer to docs/tests/ for detailed documentation on what each test covers.
