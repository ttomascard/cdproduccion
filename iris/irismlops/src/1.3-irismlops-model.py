# This script defines the machine learning model(s) used in your project.

from sklearn.ensemble import RandomForestClassifier

def create_model():
    """
    Create and configure the machine learning model.

    Returns:
        model: Configured machine learning model.
    """
    model = RandomForestClassifier(
        n_estimators=100,
        max_depth=10,
        random_state=42,
    )
    return model
