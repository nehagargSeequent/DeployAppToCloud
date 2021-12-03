resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  address_space       = [var.network.vnet_address_space]
  tags                = var.tags
}

# AKS cluster would be placed in this subnet
resource "azurerm_subnet" "k8s_subnet" {
  name                 = "k8s-subnet"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.network.node_address_space]
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
}