Project Name documentation
======================================

This is the documentation for the project Project Name. It includes detailed information on data handling, infrastructure as code (IaC), Jupyter notebooks, source code, and tests. Use the navigation below to explore each section.

Data Documentation
===================
This section includes documentation related to the raw data, processed data, and model artifacts. You can explore how each dataset is handled, processed, and stored.

.. toctree::
   :maxdepth: 2
   :caption: Data:

   data/raw.md
   data/processed.md
   data/models.md

Infrastructure as Code (IaC)
=============================
This section details how the project infrastructure is set up using Docker, GitLab CI, and Terraform. It covers containerization, continuous integration, and cloud resource provisioning.

.. toctree::
   :maxdepth: 2
   :caption: IaC:

   iac/docker.md
   iac/gitlab-ci.md
   iac/terraform.md

Jupyter Notebooks
==================
This section documents the Jupyter Notebooks used for data exploration, preprocessing, and model training. Each notebook walks through key steps of the machine learning pipeline.

.. toctree::
   :maxdepth: 2
   :caption: Notebooks:

   notebooks/data_exploration.md
   notebooks/data_preprocessing.md
   notebooks/model_training.md

Source Code
===========
The source code section covers the scripts that handle data loading, preprocessing, model definition, and training. Each script is modular and can be used independently or as part of the end-to-end pipeline.

.. toctree::
   :maxdepth: 2
   :caption: Source Code:

   src/data_loading.md
   src/data_preprocessing.md
   src/model.md
   src/train.md

Tests
======
This section contains documentation for the unit tests implemented for the project. These tests ensure the reliability and correctness of the data handling and model training code.

.. toctree::
   :maxdepth: 2
   :caption: Tests:

   tests/test_data_loading.md
   tests/test_model.md

Project Structure
=================
For a detailed explanation of the project structure, refer to the following sections:

- **README.md** files located in each folder.
- **requirements.txt**: The dependencies for the project.
