resource "azurerm_virtual_network_peering" "hub_to_spoke_dev" {
  provider            = azurerm.hub
  name                      = "hub-spoke_dev"
  resource_group_name       = azurerm_resource_group.hub_rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_spoke_dev.id
}
resource "azurerm_virtual_network_peering" "spoke_dev_to_hub" {
  provider            = azurerm.dev
  name                      = "spoke_dev-hub"
  resource_group_name       = azurerm_resource_group.spoke_dev_rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_spoke_dev.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id
}


resource "azurerm_virtual_network_peering" "hub_to_spoke_qa" {
  provider            = azurerm.hub
  name                      = "hub-spoke_qa"
  resource_group_name       = azurerm_resource_group.hub_rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_spoke_qa.id
}

resource "azurerm_virtual_network_peering" "spoke_qa_to_hub" {
  provider            = azurerm.hub
  name                      = "spoke_qa-hub"
  resource_group_name       = azurerm_resource_group.spoke_qa_rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_spoke_qa.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id
}


resource "azurerm_virtual_network_peering" "hub_to_spoke_prod" {
  provider            = azurerm.hub
  name                      = "hub-spoke_prod"
  resource_group_name       = azurerm_resource_group.hub_rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_spoke_prod.id
}
resource "azurerm_virtual_network_peering" "spoke_prod_to_hub" {
  provider            = azurerm.dev
  name                      = "spoke_prod-hub"
  resource_group_name       = azurerm_resource_group.spoke_prod_rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_spoke_prod.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id
}