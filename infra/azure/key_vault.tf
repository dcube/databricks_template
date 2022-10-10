# Create Azure Key Vault dedicated to databricks
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
resource "azurerm_key_vault" "key_vault_core" {
  name                        = var.key_vault_name
  resource_group_name         = data.azurerm_resource_group.project_resource_group.name
  location                    = data.azurerm_resource_group.project_resource_group.location
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = var.white_list_ips
    virtual_network_subnet_ids = [azurerm_subnet.public.id, azurerm_subnet.private.id]
  }

  tags = merge(data.azurerm_resource_group.project_resource_group.tags, { Role = "Key vault utilisé comme secret scope sur Databricks" })
}

# #############################################################################
# Access policies
# #############################################################################

# Add Policies to Azure Dev Ops Service Principal
resource "azurerm_key_vault_access_policy" "keyvault_policies_azure_devops" {
  key_vault_id = azurerm_key_vault.key_vault_core.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "List",
    "Backup",
    "Delete",
    "Purge",
    "Recover",
    "Restore",
    "Set"
  ]
}
