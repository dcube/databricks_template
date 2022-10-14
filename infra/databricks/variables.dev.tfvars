# project settings
project_resource_group = "rg-blog-dev-01"

# databricks
databricks_workspace_name          = "dbw-blog-dev-01"
databricks_job_cluster_worker_type = "Standard_DS3_v2"
databricks_cluster_version         = "11.2.x-scala2.12"
databricks_job_list = [
  {
    name          = "Cluster-test"
    num_workers   = 0
    libraries     = []
    init_script   = "nintendo/install_dependencies.sh"
    notebook_path = "/Shared/Cluster-test"
  }
]

# key vault
key_vault_name = "kv-blog-dcube-dev-01"

# Sql Warehouse
databricks_sql_warehouse_name = "Sql Warehouse Power BI"
databricks_sql_warehouse_size = "2X-Small"
databricks_sql_serverless     = true