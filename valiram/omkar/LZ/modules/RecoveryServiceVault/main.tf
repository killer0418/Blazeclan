resource "azurerm_recovery_services_vault" "rsv" {
  name =var.recoveryvaultName
  location = var.location
  resource_group_name = var.rsvResourcegroup
  sku= var.rsvSKU
}