resource "azurerm_resource_group" "project-resource-group" {
  name     = join("-", [var.deployment-enviroment, var.project-name, "RG"])
  location = var.deployment-location
  tags = {
    enviroment = var.deployment-enviroment
  }
}

resource "azurerm_virtual_network" "project-vnet" {
  name                = join("-", [var.deployment-enviroment, var.project-name, "VNET"])
  location            = var.deployment-location
  resource_group_name = azurerm_resource_group.project-resource-group.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    enviroment = var.deployment-enviroment
  }
}