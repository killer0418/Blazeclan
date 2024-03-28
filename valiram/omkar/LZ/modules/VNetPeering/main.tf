resource "azurerm_virtual_network_peering" "peering" {
  name                      = var.vnet_peername # "peer1to2"
  resource_group_name       = var.vnet_rg
  virtual_network_name      = var.vnet_name
  remote_virtual_network_id = var.virtual_network_ids
}
