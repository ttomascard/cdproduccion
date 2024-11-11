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

resource "azurerm_container_registry" "iris" {
  name                = "${local.prefix}${var.environment}irisacr"
  resource_group_name = local.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = local.common_tags
}



# # build the docker image
# resource "docker_image" "backend_image" {
#   name = var.backend_image_name
#   build {
#     context    = "../../"
#     dockerfile = "iac/docker/backend/Dockerfile"
#     tag        = ["${azurerm_container_registry.iris.login_server}/${var.backend_image_name}"]
#     platform = "linux/amd64"
#   }
#   provisioner "local-exec" {
#     command = "docker login ${azurerm_container_registry.iris.login_server} -u ${azurerm_container_registry.iris.admin_username} -p ${azurerm_container_registry.iris.admin_password}"
#   }

#   provisioner "local-exec" {
#     command = "docker push ${azurerm_container_registry.iris.login_server}/${var.backend_image_name}"
#   }
# }

resource "docker_image" "backend_fn" {
  name = var.backend_image_name
  build {
    context    = "../../"
    dockerfile = "iac/docker/backend-fn/Dockerfile"
    tag        = ["${azurerm_container_registry.iris.login_server}/${var.backend_function_imagen_name}"]
    platform = "linux/amd64"
  }
  provisioner "local-exec" {
    command = "docker login ${azurerm_container_registry.iris.login_server} -u ${azurerm_container_registry.iris.admin_username} -p ${azurerm_container_registry.iris.admin_password}"
  }
  provisioner "local-exec" {
    command = "docker push ${azurerm_container_registry.iris.login_server}/${var.backend_function_imagen_name}"
  }
}

resource "docker_image" "frontend_fn" {
  name = var.frontend_function_imagen_name
  build {
    context    = "../../"
    dockerfile = "iac/docker/frontend-fn/Dockerfile"
    tag        = ["${azurerm_container_registry.iris.login_server}/${var.frontend_function_imagen_name}"]
    platform = "linux/amd64"
  }
  provisioner "local-exec" {
    command = "docker login ${azurerm_container_registry.iris.login_server} -u ${azurerm_container_registry.iris.admin_username} -p ${azurerm_container_registry.iris.admin_password}"
  }

  provisioner "local-exec" {
    command = "docker push ${azurerm_container_registry.iris.login_server}/${var.frontend_function_imagen_name}"
  }
}

# resource "docker_image" "frontend_image" {
#   name = var.frontend_imagen_name
#   build {
#     context    = "../../"
#     dockerfile = "iac/docker/frontend/Dockerfile"
#     tag        = ["${azurerm_container_registry.iris.login_server}/${var.frontend_imagen_name}"]
#     platform = "linux/amd64"
#   }
#   provisioner "local-exec" {
#     command = "docker login ${azurerm_container_registry.iris.login_server} -u ${azurerm_container_registry.iris.admin_username} -p ${azurerm_container_registry.iris.admin_password}"
#   }

#   provisioner "local-exec" {
#     command = "docker push ${azurerm_container_registry.iris.login_server}/${var.frontend_imagen_name}"
#   }
# }

# create a container app Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "log-analytics-ws" {
  name                = "${local.prefix}-${var.environment}-iris-log-analytics"
  location            = var.location
  resource_group_name = local.resource_group_name
  sku                 = "PerGB2018"
  tags                = local.common_tags
}

# create a container app environment
resource "azurerm_container_app_environment" "iris-container-app-environment" {
  name                       = "${local.prefix}-${var.environment}-iris-app-environment"
  location                   = var.location
  resource_group_name        = local.resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log-analytics-ws.id
  tags                       = local.common_tags
}

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

# Create the Azure Container App
resource "azurerm_container_app" "backend_container_app" {
  name                         = "${local.prefix}-${var.environment}-iris-be-app"
  resource_group_name          = local.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.iris-container-app-environment.id
  revision_mode                = "Single"
  tags                         = local.common_tags

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.container_app_identity.id]
  }

  registry {
    server   = azurerm_container_registry.iris.login_server
    identity = azurerm_user_assigned_identity.container_app_identity.id
  }

  template {
    container {
      name   = "backend"
      image  = "${azurerm_container_registry.iris.login_server}/${var.backend_image_name}"
      cpu    = 0.25
      memory = "0.5Gi" 
    }
    max_replicas = 1
  }
  ingress {
    target_port = 8080
    external_enabled = true
    traffic_weight {
      percentage = 100
      latest_revision = true
    }
  }
}
# Create the Azure Container App
resource "azurerm_container_app" "backend_function_container_app" {
  name                         = "${local.prefix}-${var.environment}-iris-be-function-app"
  resource_group_name          = local.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.iris-container-app-environment.id
  revision_mode                = "Single"
  tags                         = local.common_tags
  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.container_app_identity.id]
  }
  registry {
    server   = azurerm_container_registry.iris.login_server
    identity = azurerm_user_assigned_identity.container_app_identity.id
  }
  template {
    container {
      name   = "backend-function"
      image  = "${azurerm_container_registry.iris.login_server}/${var.backend_function_imagen_name}"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    max_replicas = 1
    min_replicas = 0
  }
  ingress {
    target_port = 80
    external_enabled = true
    traffic_weight {
      percentage = 100
      latest_revision = true
    }
  }
}

resource "azurerm_container_app" "frontend_function_container_app" {
  name                         = "${local.prefix}-${var.environment}-iris-fe-function-app"
  resource_group_name          = local.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.iris-container-app-environment.id
  revision_mode                = "Single"
  tags                         = local.common_tags

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.container_app_identity.id]
  }

  registry {
    server   = azurerm_container_registry.iris.login_server
    identity = azurerm_user_assigned_identity.container_app_identity.id
  }

  template {
    container {
      name   = "frontend-function"
      image  = "${azurerm_container_registry.iris.login_server}/${var.frontend_function_imagen_name}"
      cpu    = 0.25
      memory = "0.5Gi" 

      env {
        name  = "PREDICTION_SERVER_URL"
        value = "https://${azurerm_container_app.backend_container_app.latest_revision_fqdn}" # Apunta al backend
      }
    }
    max_replicas = 1
  }
  ingress {
    target_port = 8501
    external_enabled = true

    traffic_weight {
      percentage = 100
      latest_revision = true
    }
  }
}

resource "azurerm_container_app" "frontend_container_app" {
  name                         = "${local.prefix}-${var.environment}-iris-fe-app"
  resource_group_name          = local.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.iris-container-app-environment.id
  revision_mode                = "Single"
  tags                         = local.common_tags

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.container_app_identity.id]
  }

  registry {
    server   = azurerm_container_registry.iris.login_server
    identity = azurerm_user_assigned_identity.container_app_identity.id
  }

  template {
    container {
      name   = "irisfrontend"
      image  = "${azurerm_container_registry.iris.login_server}/${var.frontend_imagen_name}"
      cpu    = 0.25
      memory = "0.5Gi" 

      env {
        name  = "PREDICTION_SERVER_URL"
        value = "https://${azurerm_container_app.backend_container_app.latest_revision_fqdn}" # Apunta al backend
      }
    }
    max_replicas = 1
  }
  ingress {
    target_port = 8501
    external_enabled = true

    traffic_weight {
      percentage = 100
      latest_revision = true
    }
  }
}







resource "azurerm_resource_group" "tomgrupo" {
  name     = "tomgrupo"
  location = "eastus"
}

resource "azurerm_service_plan" "tomplanserv" {
  name                = "tomplanserv"
  resource_group_name = azurerm_resource_group.tomgrupo.name
  location            = azurerm_resource_group.tomgrupo.location
  os_type             = "Linux"
  sku_name            = "B1"
}


resource "azurerm_storage_account" "tomlabstorage" {
  name                     = "tomupbdsplaboratoriodev"
  resource_group_name      = "dsproduccion202402"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "dev"
    owner = "tomas.cardona@upb.edu.co"
    project = "tomas-ds-produccion"
  }
}



resource "azurerm_windows_function_app" "tomfunction" {
  name                = "tomfunction"
  resource_group_name = azurerm_resource_group.tomgrupo.name
  location            = azurerm_resource_group.tomgrupo.location

  storage_account_name       = azurerm_storage_account.tomlabstorage.name
  storage_account_access_key = azurerm_storage_account.tomlabstorage.primary_access_key
  service_plan_id            = azurerm_service_plan.tomplanserv.id
  site_config {}
}






