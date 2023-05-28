# Creates the resource group which will contain all the project resources.
resource "azurerm_resource_group" "project-resource-group" {
  name     = join("-", [var.deployment-enviroment, var.project-name, "RG"])
  location = var.deployment-location
  tags = {
    enviroment = var.deployment-enviroment
  }
}

# Creates the vnet for the projects resources.
resource "azurerm_virtual_network" "project-vnet" {
  name                = join("-", [var.project-name, "VNET"])
  location            = var.deployment-location
  resource_group_name = azurerm_resource_group.project-resource-group.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    enviroment = var.deployment-enviroment
  }
}

# Creates the management subnet.
resource "azurerm_subnet" "management-subnet" {
  name                 = join("-", [var.project-name, "management-SUBNET"])
  resource_group_name  = azurerm_resource_group.project-resource-group.name
  virtual_network_name = azurerm_virtual_network.project-vnet.name
  address_prefixes     = ["10.0.2.0/25"]
}

# Creates the management VM and attached NIC.
module "management-vm" {
  source            = "./modules/vm"
  vm-name           = join("-", [var.project-name, "management-VM"])
  vm-resource-group = azurerm_resource_group.project-resource-group.name
  vm-location       = var.deployment-location
  vm-public-key     = var.DEFAULT_SSHKEY
  vm-size           = var.management-vm-size
  vm-subnet-id      = azurerm_subnet.management-subnet.id
}