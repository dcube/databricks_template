# az login
# az account set --subscription "-----"
# terraform init
# terraform plan --var-file=terraform.dev.tfvars

#  Common data sources used by all modules
data "azurerm_client_config" "current" {}

# Reference to the project ressource group
data "azurerm_resource_group" "project_resource_group" {
  name = var.project_resource_group
}

# data "azuread_service_principal" "spn" {
#   display_name = var.spn_name
# }
