
resource "azurerm_virtual_network" "vnet_t2" {
  name                = var.vnet_name_t2
  location            = var.location
  resource_group_name = var.rg_name_t2
  address_space       = var.address_space_t2
  tags = var.tags_t2
}

resource "azurerm_subnet" "subnet_t2" {
  
  count = length(var.subnets_data_t2)
  name                = lookup(var.subnets_data_t2[count.index], "name")
  resource_group_name  = azurerm_virtual_network.vnet_t2.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_t2.name
  address_prefixes     = [lookup(var.subnets_data_t2[count.index], "address_prefixes")]
}