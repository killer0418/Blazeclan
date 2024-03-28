output "nic_ids" {
  value = azurerm_network_interface.nic_t2.*.id
}