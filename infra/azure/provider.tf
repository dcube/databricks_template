#  Terraform backend
terraform {
  required_version = ">=1.2.9"
  # backend "azurerm" {
  #   resource_group_name  = "rg-infra-common-dev-westeu-01"
  #   storage_account_name = "stfocusterraformdev01"
  #   container_name       = "terraform"
  #   key                  = "terraform-paf-sales-base-dev.tfstate"
  # }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.20.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}