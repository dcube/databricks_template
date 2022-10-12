# https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/sql_endpoint
resource "databricks_sql_endpoint" "this" {
  name                      = var.databricks_sql_warehouse_name
  cluster_size              = var.databricks_sql_warehouse_size
  enable_serverless_compute = var.databricks_sql_serverless

  tags {
    custom_tags {
      key   = "Application"
      value = "PowerBi"
    }
  }
}

resource "databricks_sql_global_config" "this" {
  security_policy = "DATA_ACCESS_CONTROL"
  data_access_config = {
    "spark.hadoop.fs.azure.account.auth.type" : "OAuth",
    "spark.hadoop.fs.azure.account.oauth.provider.type" : "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
    "spark.hadoop.fs.azure.account.oauth2.client.id" : "{{secrets/${local.secret_scope_name}/spn-sales-id}}",
    "spark.hadoop.fs.azure.account.oauth2.client.secret" : "{{secrets/${local.secret_scope_name}/spn-sales-secret}}",
    "spark.hadoop.fs.azure.account.oauth2.client.endpoint" : "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/oauth2/token"
  }
  sql_config_params = {
    "ANSI_MODE" : "true"
  }
}