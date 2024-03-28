resource "azurerm_subnet" "firewall_subnet" {
  provider            = azurerm.hub
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["192.168.2.0/24"]
}

resource "azurerm_subnet" "hub_subnet" {
  provider            = azurerm.hub
  name                 = "default"
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["192.168.1.0/24"]
}

resource "azurerm_subnet" "spoke_dev_subnet" {
  provider            = azurerm.dev
  name                 = var.spoke_dev_subnet_name
  resource_group_name  = azurerm_resource_group.spoke_dev_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke_dev.name
  address_prefixes     = ["172.16.1.0/24"]
}
resource "azurerm_subnet" "spoke_qa_subnet" {
  provider            = azurerm.hub
  name                 = "spoke_qa-subnet"
  resource_group_name  = azurerm_resource_group.spoke_qa_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke_qa.name
  address_prefixes     = ["172.17.1.0/24"]
}
resource "azurerm_subnet" "spoke_prod_subnet" {
  provider            = azurerm.dev
  name                 = var.spoke_prod_subnet_name
  resource_group_name  = azurerm_resource_group.spoke_prod_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke_prod.name
  address_prefixes     = ["172.18.1.0/24"]
}