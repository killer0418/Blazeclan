resource "azurerm_recovery_services_vault" "vault" {
  name                = var.vaultname
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  soft_delete_enabled = true
  
}





