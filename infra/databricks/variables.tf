variable "project_resource_group" {
  type = string
}

#####################
# Databricks
#####################

variable "databricks_workspace_name" {
  type = string
}

variable "databricks_job_cluster_worker_type" {
  type = string
}

#####################
# Key vault
#####################

variable "key_vault_name" {
  type = string
}

#####################
# SQL Warehouse
#####################

variable "databricks_sql_warehouse_name" {
  type = string
}

variable "databricks_sql_warehouse_size" {
  type = string
}

variable "databricks_sql_serverless" {
  type = bool
}