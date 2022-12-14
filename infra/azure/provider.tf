#  Terraform backend
terraform {
  required_version = ">=1.2.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.20.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.28.1"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}

# Configure the Azure Active Directory Provider
provider "azuread" {
}