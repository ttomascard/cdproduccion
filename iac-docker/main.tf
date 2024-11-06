# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# resource "azurerm_storage_account" "laboratorio" {
#   name                     = "tomupbdsplaboratoriodev"
#   resource_group_name      = "dsproduccion202402"
#   location                 = "eastus"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   tags = {
#     environment = "dev"
#     owner = "tomas.cardona@upb.edu.co"
#     project = "tomas-ds-produccion"
#   }
# }

# resource "docker_container" "contenedorServWeb" {
#   image = docker_image.flaskimage.image_id
#   name  = "laboratorio"
#   ports {
#     internal = 8080
#     external = 8081
#   }
# }

# resource "docker_image" "flaskimage" {
#   name = "laboratorio-flask"
#   build {
#     context = "../flask-docker"
#     tag     = ["laboratorio-ds"]
#   }
# }