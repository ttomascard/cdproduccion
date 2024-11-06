# GitLab CI Documentation

This document explains the Continuous Integration/Continuous Deployment (CI/CD) process configured with GitLab CI.

## Pipeline Configuration

The GitLab CI pipeline is defined in `.gitlab-ci.yml`, located in the `iac/gitlab-ci/` directory.

### Stages

1. **Install Dependencies**: Installs all necessary dependencies using `requirements.txt`.
2. **Linting**: Runs code linting to ensure compliance with style guides.
3. **Testing**: Executes unit tests found in the `tests/` folder.
4. **Build**: Builds the Docker image for deployment.
5. **Deploy**: Deploys the application to the target environment.

### How to Run the Pipeline

The pipeline is automatically triggered on each commit to the repository. To manually trigger a pipeline, navigate to the CI/CD section of GitLab and click "Run Pipeline."

### Customization

To add more stages or adjust the current ones, modify the `.gitlab-ci.yml` file accordingly.
