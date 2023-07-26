terraform {
  # Azure Backend
  backend "azurerm" {
    resource_group_name  = "Terraform-Resources-RG"
    storage_account_name = "demoresources97"
    container_name       = "terraform-state"
    key                  = "test.terraform.tfstate"
  }
  # Providers required by this project & their specified versions.
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.66.0"
    }
  }
}

# Provider configuration options.
provider "azurerm" {
  features {}
}