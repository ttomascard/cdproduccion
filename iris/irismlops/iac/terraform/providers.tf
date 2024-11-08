terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.1.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.13.0"
    }
  }
}
provider "docker" {
  host = "unix:///var/run/docker.sock"
}
