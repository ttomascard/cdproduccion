# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "docker"{}

locals {
  common_tags = {
    environment = var.environment
    project = "iris"
    owner  = "tomas.cardona@upb.edu.co"
  }
  prefix = "tom"
  resource_group_name = "dsproduccion202402"
}

resource "azurerm_storage_account" "function_storage_account" {
  name                     = "${local.prefix}${var.environment}functionstorage"
  resource_group_name      = local.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = local.common_tags
}

resource "azurerm_container_registry" "iris" {
  name                = "${local.prefix}${var.environment}iris"
  resource_group_name = local.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = local.common_tags
}

# build the docker image
resource "docker_image" "backend_image" {
  name = var.backend_image_name
  build {
    context    = "../../"
    dockerfile = "iac/docker/backend/Dockerfile"
    tag        = ["${azurerm_container_registry.iris.login_server}/${var.backend_image_name}"]
    platform = "linux/amd64"
  }
  provisioner "local-exec" {
    command = "docker login ${azurerm_container_registry.iris.login_server} -u ${azurerm_container_registry.iris.admin_username} -p ${azurerm_container_registry.iris.admin_password}"
  }

  provisioner "local-exec" {
    command = "docker push ${azurerm_container_registry.iris.login_server}/${var.backend_image_name}"
  }
}

# create a container app Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "log-analytics-ws" {
  name                = "${local.prefix}-${var.environment}-iris-log-analytics"
  location            = var.location
  resource_group_name = local.resource_group_name
  sku                 = "PerGB2018"
  tags                = local.common_tags
}

# # create a container app environment
# resource "azurerm_container_app_environment" "backend-container-app-environment" {
#   name                       = "${local.prefix}-${var.environment}-iris-app-environment"
#   location                   = var.location
#   resource_group_name        = local.resource_group_name
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.log-analytics-ws.id
#   tags                       = local.common_tags
# }

resource "azurerm_user_assigned_identity" "container_app_identity" {
  name                = "${local.prefix}-${var.environment}-container-app-identity"
  resource_group_name = local.resource_group_name
  location            = var.location
}
 
# Asignar el rol 'AcrPull' a la identidad administrada para el ACR
resource "azurerm_role_assignment" "acr_pull_role" {
  principal_id   = azurerm_user_assigned_identity.container_app_identity.principal_id
  role_definition_name = "AcrPull"
  scope          = azurerm_container_registry.iris.id
}
