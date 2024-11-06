# This script contains unit tests for the model.py module.

import unittest
from src.model import create_model
import numpy as np

class TestModel(unittest.TestCase):
    def test_create_model(self):
        model = create_model()
        self.assertIsNotNone(model)

    def test_model_training(self):
        model = create_model()
        X_train = np.array([[0, 1], [1, 0], [1, 1]])
        y_train = np.array([0, 1, 1])
        model.fit(X_train, y_train)
        self.assertTrue(hasattr(model, 'n_features_in_'))

    def test_model_prediction(self):
        model = create_model()
        X_train = np.array([[0, 1], [1, 0], [1, 1]])
        y_train = np.array([0, 1, 1])
        model.fit(X_train, y_train)
        X_test = np.array([[0, 0], [1, 1]])
        predictions = model.predict(X_test)
        self.assertEqual(len(predictions), len(X_test))

if __name__ == '__main__':
    unittest.main()
