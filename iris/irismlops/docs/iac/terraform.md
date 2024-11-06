# Terraform Documentation

This document explains the use of Terraform for provisioning cloud infrastructure.

## Files

- **main.tf**: Contains the primary Terraform configuration, defining cloud resources like servers, databases, etc.
- **variables.tf**: Defines input variables that can be passed to the configuration to customize the deployment.
- **outputs.tf**: Contains output variables, such as server IP addresses, that are printed after deployment.

### Running Terraform

1. Initialize Terraform:

```bash
terraform init
```

Apply the Terraform configuration:

```bash
terraform apply
```

### Key Resources

The resources created by the Terraform script include:

- Virtual Machines
- Databases
- Load Balancers (if any)

### Managing Terraform State

Terraform keeps track of the infrastructure's state using a state file. Ensure this file is securely stored, as it is critical for Terraform to manage the infrastructure correctly.

