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

variable "databricks_cluster_version" {
  type = string
}

variable "databricks_job_list" {
  type = list(object({
    name          = string
    num_workers   = number
    libraries     = list(string)
    init_script   = string
    notebook_path = string
  }))
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