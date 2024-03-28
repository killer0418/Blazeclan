output "subnet_id" {
  value = azurerm_subnet.subnet_t2.*.id
}
output "virtual_network_id" {
  value = azurerm_virtual_network.vnet_t2.id
}
output "virtual_network_name" {
  value = azurerm_virtual_network.vnet_t2.name
}