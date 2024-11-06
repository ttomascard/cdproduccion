#!/bin/bash

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null
then
    echo "Python3 is not installed. Please install Python3 first."
    exit
fi

# Create virtual environment
python3 -m venv .venv

# Activate virtual environment
source .venv/bin/activate

# Install requirements
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
else
    echo "requirements.txt not found. Please add your project dependencies."
fi

echo "Virtual environment is set up and activated."
