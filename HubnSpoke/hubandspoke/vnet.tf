resource "azurerm_virtual_network" "vnet_hub" {
  provider            = azurerm.hub
  name                = var.hub_vnet_name
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  address_space       = ["192.168.0.0/16"]
  dns_servers         = ["192.168.0.4", "192.168.0.5"]
  tags = var.default_tags
}

resource "azurerm_virtual_network" "vnet_spoke_dev" {
  provider            = azurerm.dev
  name                = var.spoke_dev_vnet_name
  location            = azurerm_resource_group.spoke_dev_rg.location
  resource_group_name = azurerm_resource_group.spoke_dev_rg.name
  address_space       = ["172.16.0.0/16"]
  dns_servers         = ["172.16.0.4", "172.16.0.5"]
  tags = var.default_tags
}
resource "azurerm_virtual_network" "vnet_spoke_qa" {
  provider            = azurerm.hub
  name                = var.spoke_qa_vnet_name
  location            = azurerm_resource_group.spoke_qa_rg.location
  resource_group_name = azurerm_resource_group.spoke_qa_rg.name
  address_space       = ["172.17.0.0/16"]
  dns_servers         = ["172.17.0.4", "172.17.0.5"]
  tags = var.default_tags
}
resource "azurerm_virtual_network" "vnet_spoke_prod" {
  provider            = azurerm.dev
  name                = var.spoke_prod_vnet_name
  location            = azurerm_resource_group.spoke_prod_rg.location
  resource_group_name = azurerm_resource_group.spoke_prod_rg.name
  address_space       = ["172.18.0.0/16"]
  dns_servers         = ["172.18.0.4", "172.18.0.5"]
  tags = var.default_tags
}