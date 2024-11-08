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

