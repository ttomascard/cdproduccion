# Infrastructure as Code (IaC) Folder

This folder contains all Infrastructure as Code (IaC) configurations necessary for setting up and deploying the project infrastructure.

## Subfolders

- **docker/**: Contains the `Dockerfile` for building the project’s Docker container.
- **gitlab-ci/**: Configuration for the GitLab CI/CD pipeline, including stages for testing, building, and deploying the project.
- **terraform/**: Contains Terraform scripts for provisioning cloud infrastructure, such as virtual machines, databases, and other resources.

## Usage

- **Docker**: Build and run the Docker container to ensure consistency across environments.
- **GitLab CI**: The pipeline automatically runs tests and deployments on each push or merge request.
- **Terraform**: Use Terraform scripts to deploy cloud resources needed for the project.

Refer to the individual `docs/iac/` markdown files for detailed instructions on using each tool.
