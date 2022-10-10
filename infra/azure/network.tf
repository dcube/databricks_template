resource "azurerm_virtual_network" "this" {
  name = var.databricks_vnet_name

  location            = data.azurerm_resource_group.project_resource_group.location
  resource_group_name = data.azurerm_resource_group.project_resource_group.name

  address_space = ["10.139.0.0/16"]
}

resource "azurerm_subnet" "private" {
  name = var.databricks_private_subnet

  resource_group_name  = data.azurerm_resource_group.project_resource_group.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.139.64.0/18"]

  service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]

  delegation {
    name = "databricks-delegation"

    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
    }
  }
}

resource "azurerm_network_security_group" "private" {
  name = var.databricks_private_security_group

  location            = data.azurerm_resource_group.project_resource_group.location
  resource_group_name = data.azurerm_resource_group.project_resource_group.name
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.private.id
}

resource "azurerm_subnet" "public" {
  name = var.databricks_public_subnet

  resource_group_name  = data.azurerm_resource_group.project_resource_group.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.139.0.0/18"]


  service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]

  delegation {
    name = "databricks-delegation"

    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
    }
  }
}

resource "azurerm_network_security_group" "public" {
  name = var.databricks_public_security_group

  location            = data.azurerm_resource_group.project_resource_group.location
  resource_group_name = data.azurerm_resource_group.project_resource_group.name
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.public.id
}