@echo off
REM Check if Python is installed
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python is not installed. Please install Python first.
    exit /b
)

REM Create virtual environment
python -m venv .venv

REM Activate virtual environment
call .venv\Scripts\activate

REM Install requirements
if exist requirements.txt (
    pip install -r requirements.txt
) else (
    echo requirements.txt not found. Please add your project dependencies.
)

echo Virtual environment is set up and activated.
