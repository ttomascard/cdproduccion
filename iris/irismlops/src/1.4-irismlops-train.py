# This script contains functions to train the model.

def train_model(model, X_train, y_train):
    """
    Train the machine learning model.

    Args:
        model: The machine learning model to train.
        X_train (pd.DataFrame or np.array): Training features.
        y_train (pd.Series or np.array): Training labels.

    Returns:
        model: Trained machine learning model.
    """
    model.fit(X_train, y_train)
    print("Model training completed.")
    return model
