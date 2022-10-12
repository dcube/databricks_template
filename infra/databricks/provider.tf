#  Terraform backend
terraform {
  required_version = ">=1.2.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.20.0"
    }

    databricks = {
      source  = "databricks/databricks"
      version = "1.3.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}

provider "databricks" {
  host = data.azurerm_databricks_workspace.this.workspace_url
}