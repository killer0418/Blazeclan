output "subnet_id" {
    value = "${azurerm_subnet.spoke_prod_subnet.id}"
}
output "subnet1_id" {
    value = "${azurerm_subnet.spoke_dev_subnet.id}"
}