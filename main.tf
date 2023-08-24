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

# A data source containg the configuration of the AzureRM provider, subscription or tentant ID's for example.
data "azurerm_client_config" "current" {}

# Creates the key vault.
resource "azurerm_key_vault" "key-vault" {
  name                        = join("-", [var.project-name, "key-vault"])
  location                    = var.deployment-location
  resource_group_name         = azurerm_resource_group.project-resource-group.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization   = true

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "Delete",
      "List",
      "Set",
      "Backup"
    ]

    key_permissions = [
    ]

    storage_permissions = [
    ]
  }

}

# Creates a NSG with inbound rules for the management subnet.
module "management-nsg" {
  source            = "./modules/nsg"
  nsg-name          = join("-", [var.project-name, "management-NSG"])
  resource-group    = azurerm_resource_group.project-resource-group.name
  deploy-location   = var.deployment-location
  inbound-tcp-rules = var.management-nsg-inbound-rules
}
# Generates the SSH keys for the managment VM.
resource "tls_private_key" "key-pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Storing the management VMs private SSH key in the key vault.
resource "azurerm_key_vault_secret" "managment-vm-private-key" {
  name         = join("-", [var.project-name, "management-vm-PK"])
  value        = tls_private_key.key-pair.private_key_openssh
  key_vault_id = azurerm_key_vault.key-vault.id
}

# Creates the management VM and attached NIC.
module "management-vm" {
  source          = "./modules/vm"
  vm-name         = join("-", [var.project-name, "management-VM"])
  resource-group  = azurerm_resource_group.project-resource-group.name
  deploy-location = var.deployment-location
  vm-public-key   = tls_private_key.key-pair.public_key_openssh
  vm-size         = var.management-vm-size
  subnet-id       = azurerm_subnet.management-subnet.id
}

#
module "kafka-env" {
  source = "./modules/container-app-environment"
  env-name = "kafka"
  resource-group = azurerm_resource_group.project-resource-group.name
  deploy-location = azurerm_resource_group.project-resource-group.location
  retention = 30
}

#
module "kafka" {
  source = "./modules/container-app"
  depends_on = [ module.kafka-env ]
  app-name = "kafka"
  resource-group = azurerm_resource_group.project-resource-group.name
  env-id = module.kafka-env.container-env-id
  image = "docker.io/ubuntu/kafka:latest"
  cpu = 0.25
  memory = "0.5Gi"
  replicas-max = 1
  replicas-min = 1
  commands = ["/bin/sleep","infinity"]
}

module "zookeeper" {
  source = "./modules/container-app"
  app-name = "zookeeper"
  resource-group = azurerm_resource_group.project-resource-group.name
  env-id = module.kafka-env.container-env-id
  image = "docker.io/ubuntu/zookeeper:latest"
  cpu = 0.25
  memory = "0.5Gi"
  replicas-max = 1
  replicas-min = 1
  commands = ["/bin/sleep","infinity"]
}