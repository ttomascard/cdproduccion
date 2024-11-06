# irismlops

Proyeecto de iris db para cdproduccion

## How to clone this template using cookiecutter?

1. Install cookiecutter in your local machine running the following command:
  ```bash
  pip install cookiecutter
  ```

2. Run the command to copy the template and answer the questions such as project name, author and version
  ```bash
  cookiecutter --checkout cookiecutter https://gitlab.com/upb-med/NRC22462/e1-g4.git
  ```

## Virtual environment installation

- For Unix systems (MacOS and Linux):
  ```bash
  ./setup_env.sh
  ```
- For Windows systems run:
  ```cmd
  setup_env.bat
  ```

### Activate virtual environment

- For Unix systems (MacOS and Linux):
  ```bash
  source .venv/bin/activate
  ```
- For Windows systems run:
  ```cmd
  .\.venv\Scripts\activate
  ```

## Docs with Sphinx

Generate the documentation running the following commands:

- For Unix systems (MacOS and Linux):
  ```bash
  cd docs/
  make html && make pdf
  ```
- For Windows systems run:
  ```cmd
  cd docs/
  .\make.bat html
  .\make.bat pdf
  ```

