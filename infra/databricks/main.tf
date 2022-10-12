data "azurerm_client_config" "current" {}

# Reference to the project ressource group
data "azurerm_resource_group" "project_resource_group" {
  name = var.project_resource_group
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/databricks_workspace
data "azurerm_databricks_workspace" "this" {
  name                = var.databricks_workspace_name
  resource_group_name = var.project_resource_group
}

data "azurerm_key_vault" "key_vault_databricks" {
  name                = var.key_vault_name
  resource_group_name = var.project_resource_group
}