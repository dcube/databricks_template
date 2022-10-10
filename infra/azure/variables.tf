# project settings
variable "project_resource_group" {
  type = string
}

#####################
# Databricks
#####################

variable "databricks_workspace_name" {
  type = string
}

variable "databricks_workspace_managed_resource_group" {
  type = string
}

variable "databricks_file_storage_name" {
  type = string
}

#####################
# Network
#####################

variable "databricks_vnet_name" {
  type = string
}

variable "databricks_public_subnet" {
  type = string
}

variable "databricks_private_subnet" {
  type = string
}

variable "databricks_private_security_group" {
  type = string
}

variable "databricks_public_security_group" {
  type = string
}

variable "white_list_ips" {
  type = set(string)
}

#####################
# Data lake
#####################

variable "datalake_name" {
  type = string
}

#####################
# Key Vault
#####################
variable "key_vault_name" {
  type = string
}