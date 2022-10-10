# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace
resource "azurerm_databricks_workspace" "this" {
  name                          = var.databricks_workspace_name
  location                      = data.azurerm_resource_group.project_resource_group.location
  resource_group_name           = data.azurerm_resource_group.project_resource_group.name
  sku                           = "standard"
  managed_resource_group_name   = var.databricks_workspace_managed_resource_group
  public_network_access_enabled = true

  custom_parameters {
    storage_account_name                                 = var.databricks_file_storage_name
    storage_account_sku_name                             = "Standard_LRS" # Standard_LRS ou Standard_GRS uniquement possible
    virtual_network_id                                   = azurerm_virtual_network.this.id
    public_subnet_name                                   = azurerm_subnet.public.name
    private_subnet_name                                  = azurerm_subnet.private.name
    public_subnet_network_security_group_association_id  = azurerm_network_security_group.public.id
    private_subnet_network_security_group_association_id = azurerm_network_security_group.private.id
  }

  depends_on = [
    azurerm_subnet_network_security_group_association.public,
    azurerm_subnet_network_security_group_association.private,
  ]

  tags = merge(data.azurerm_resource_group.project_resource_group.tags, { Role = "Workspace Databricks de developpement pour les data engineers" })
}