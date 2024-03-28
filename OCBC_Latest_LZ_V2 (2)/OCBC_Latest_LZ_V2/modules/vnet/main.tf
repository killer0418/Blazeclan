
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.address_space
  tags = var.tags
}

resource "azurerm_subnet" "subnet" {
  count = length(var.subnets_data)
  name                = lookup(var.subnets_data[count.index], "name")
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [lookup(var.subnets_data[count.index], "address_prefixes")]
}
