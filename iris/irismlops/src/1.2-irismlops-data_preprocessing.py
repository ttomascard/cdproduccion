# This script contains functions for data cleaning, encoding, and scaling.

import pandas as pd
from sklearn.preprocessing import LabelEncoder, StandardScaler

def handle_missing_values(df):
    """
    Handle missing values in the DataFrame.

    Args:
        df (pd.DataFrame): The DataFrame to process.

    Returns:
        pd.DataFrame: DataFrame with missing values handled.
    """
    # Fill numerical columns with median
    numerical_cols = df.select_dtypes(include=['int64', 'float64']).columns
    for col in numerical_cols:
        df[col].fillna(df[col].median(), inplace=True)

    # Fill categorical columns with mode
    categorical_cols = df.select_dtypes(include=['object']).columns
    for col in categorical_cols:
        df[col].fillna(df[col].mode()[0], inplace=True)

    return df

def encode_categorical_variables(df):
    """
    Encode categorical variables using Label Encoding.

    Args:
        df (pd.DataFrame): The DataFrame to process.

    Returns:
        pd.DataFrame: DataFrame with categorical variables encoded.
    """
    label_encoders = {}
    categorical_cols = df.select_dtypes(include=['object']).columns

    for col in categorical_cols:
        le = LabelEncoder()
        df[col] = le.fit_transform(df[col])
        label_encoders[col] = le

    return df

def scale_numerical_features(df):
    """
    Scale numerical features using StandardScaler.

    Args:
        df (pd.DataFrame): The DataFrame to process.

    Returns:
        pd.DataFrame: DataFrame with scaled numerical features.
    """
    scaler = StandardScaler()
    numerical_cols = df.select_dtypes(include=['int64', 'float64']).columns
    df[numerical_cols] = scaler.fit_transform(df[numerical_cols])
    return df
