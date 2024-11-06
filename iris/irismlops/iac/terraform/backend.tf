terraform {
  backend "azurerm" {
      resource_group_name  = "dsproduccion202402"
      storage_account_name = "terrafomstatesds"
      container_name       = "tomascard"
      key                  = "terraform-iris.tfstate"
  }

}
