# Docker Documentation

This document describes the usage of Docker in this project.

## Dockerfile

The `Dockerfile` is located in `iac/docker/Dockerfile`. It contains the instructions to build the Docker image for the project.

### Key Components

- **Base Image**: The base image used for the project (e.g., `python:3.8-slim`).
- **Dependencies**: Installations for required Python packages from `requirements.txt`.
- **Environment Variables**: Any important environment variables required for running the project.
- **Ports**: Define any necessary ports exposed by the container.

### Building the Docker Image

To build the Docker image, run:

```bash
docker build -t <image-name> .
```

### Running the Docker Container

To run the container:

```bash
docker run -p 8080:8080 <image-name>
```

Make sure to replace <image-name> with the actual name of the image.
