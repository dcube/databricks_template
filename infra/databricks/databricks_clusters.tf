# https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/job
resource "databricks_job" "this" {
  count = length(var.databricks_job_list)

  name = var.databricks_job_list[count.index].name

  dynamic "library" {
    for_each = toset(var.databricks_job_list[count.index].libraries)
    content {
      pypi {
        package = library.value
      }
    }
  }

  new_cluster {
    num_workers        = var.databricks_job_list[count.index].num_workers
    spark_version      = var.databricks_cluster_version
    node_type_id       = var.databricks_job_cluster_worker_type
    data_security_mode = "SINGLE_USER"

    spark_conf = {
      "spark.databricks.cluster.profile" : "singleNode"
      "fs.azure.account.oauth2.client.id" : "{{secrets/${local.secret_scope_name}/spn-id}}"
      "fs.azure.account.oauth.provider.type" : "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider"
      "spark.master" : "local[*, 4]"
      "fs.azure.account.oauth2.client.endpoint" : "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/oauth2/token"
      "spark.databricks.delta.preview.enabled" : true
      "fs.azure.account.auth.type" : "OAuth"
      "fs.azure.account.oauth2.client.secret" : "{{secrets/${local.secret_scope_name}/spn-secret}}"
    }

    custom_tags = {
      "ResourceClass" = "SingleNode"
    }

    dynamic "init_scripts" {
      for_each = length(var.databricks_job_list[count.index].init_script) > 0 ? [var.databricks_job_list[count.index].init_script] : []

      content {
        dbfs {
          destination = "dbfs:/FileStore/init-scripts/${init_scripts.value}"
        }
      }
    }
  }

  notebook_task {
    notebook_path = var.databricks_job_list[count.index].notebook_path
  }
}