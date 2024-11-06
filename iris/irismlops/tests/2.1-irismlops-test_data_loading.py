# This script contains unit tests for the data_loading.py module.

import unittest
import pandas as pd
from src.data_loading import load_data

class TestDataLoading(unittest.TestCase):
    def setUp(self):
        # Create a sample CSV file for testing
        self.sample_data = pd.DataFrame({
            'numeric_column': [1, 2, 3],
            'categorical_column': ['A', 'B', 'C']
        })
        self.sample_file = 'tests/sample_data.csv'
        self.sample_data.to_csv(self.sample_file, index=False)

    def test_load_data_success(self):
        df = load_data(self.sample_file)
        self.assertIsInstance(df, pd.DataFrame)
        self.assertEqual(len(df), 3)
        self.assertListEqual(list(df.columns), ['numeric_column', 'categorical_column'])

    def test_load_data_failure(self):
        df = load_data('non_existent_file.csv')
        self.assertIsNone(df)

    def tearDown(self):
        # Clean up the sample CSV file
        import os
        if os.path.exists(self.sample_file):
            os.remove(self.sample_file)

if __name__ == '__main__':
    unittest.main()
