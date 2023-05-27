# Azure Provider
provider "azurerm" {
  features {}
}

# Azure Backend
terraform {
  backend "azurerm" {
    resource_group_name   = "Terraform-Resources-RG"
    storage_account_name  = "demoresources97"
    container_name        = "terraform-state"
    key                   = "test.terraform.tfstate"
  }
}