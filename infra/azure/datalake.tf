# Create Storage Account for Datalake
resource "azurerm_storage_account" "datalake" {
  name                     = var.datalake_name
  resource_group_name      = data.azurerm_resource_group.project_resource_group.name
  location                 = data.azurerm_resource_group.project_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"
  is_hns_enabled           = "true"

  tags = merge(data.azurerm_resource_group.project_resource_group.tags, { Role = "Datalake" })

}

# Create Adls Gen2 container
resource "azurerm_storage_data_lake_gen2_filesystem" "datalake_hns" {
  name               = "datalake"
  storage_account_id = azurerm_storage_account.datalake.id
  depends_on = [
    azurerm_role_assignment.datalake_iam_devops_contributor
  ]
}

resource "azurerm_storage_account_network_rules" "datalake_network_rules" {
  storage_account_id = azurerm_storage_account.datalake.id

  default_action             = "Deny"
  bypass                     = ["Logging", "Metrics", "AzureServices"]
  ip_rules                   = var.white_list_ips
  virtual_network_subnet_ids = [azurerm_subnet.public.id, azurerm_subnet.private.id]

  depends_on = [
    azurerm_storage_data_lake_gen2_filesystem.datalake_hns
  ]
}


############################
### Assignment
############################

resource "azurerm_role_assignment" "datalake_iam_devops_contributor" {
  scope                = azurerm_storage_account.datalake.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}
