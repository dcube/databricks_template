# https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/pipeline
resource "databricks_pipeline" "plague-tale-2-update-gold-data" {
  name    = "pipeline DLT de test"
  storage = "dbfs:/pipelines/pipeline-dlt-de-test"
  target  = "GOLD"

  cluster {
    label        = "default"
    num_workers  = 1
    node_type_id = var.databricks_job_cluster_worker_type
    spark_conf = {
      "spark.databricks.cluster.profile" : "singleNode"
      "fs.azure.account.oauth2.client.id" : "{{secrets/${local.secret_scope_name}/spn-id}}"
      "fs.azure.account.oauth.provider.type" : "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider"
      "spark.databricks.unityCatalog.userIsolation.python.preview" : "true"
      "spark.master" : "local[*, 4]"
      "fs.azure.account.oauth2.client.endpoint" : "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/oauth2/token"
      "spark.databricks.delta.preview.enabled" : true
      "fs.azure.account.auth.type" : "OAuth"
      "fs.azure.account.oauth2.client.secret" : "{{secrets/${local.secret_scope_name}/spn-secret}}"
    }
  }

  library {
    notebook {
      path = "/shared/Notebooks/pipeline-dlt-de-test"
    }
  }

  continuous  = false
  development = false
  channel     = "current"
  photon      = false
  edition     = "advanced"
}