# Impossible de créer un scope secret par Azure Devops. Il faut le créer à la main par l'URL #secrets/createScope
# https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/secret
resource "databricks_secret_scope" "databricks_secret_scope_key_vault" {
  name                     = "key-vault-secret"
  initial_manage_principal = "users"

  keyvault_metadata {
    resource_id = data.azurerm_key_vault.key_vault_databricks.id
    dns_name    = data.azurerm_key_vault.key_vault_databricks.vault_uri
  }
}