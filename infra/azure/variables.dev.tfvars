# project settings
project_resource_group = "rg-blog-dev-01"

# databricks
databricks_workspace_name                   = "dbw-blog-dev-01"
databricks_workspace_managed_resource_group = "rg-blog-dev-02"
databricks_file_storage_name                = "stblogdev01"

# network
databricks_vnet_name              = "vnet-blog-dev-01"
databricks_public_subnet          = "snet-blog-dev-01"
databricks_private_subnet         = "snet-blog-dev-02"
databricks_public_security_group  = "snet-blog-dev-01"
databricks_private_security_group = "snet-blog-dev-02"
white_list_ips                    = ["78.79.80.81", "90.91.92.93"]

# datalake
datalake_name = "stblogdev02"

#key vault
key_vault_name = "kv-blog-dcube-dev-01"

#SPN
spn_name = "SPN-BLOG-DEV"