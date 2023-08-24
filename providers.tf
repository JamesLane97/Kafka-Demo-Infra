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
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

# Provider configuration options.
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = false
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}