resource "azurerm_subnet" "subnet" {
  name = var.subnetName
  resource_group_name = var.subResourceGroup
  virtual_network_name = var.subVNet
  address_prefixes = var.subAddPrefixes
}