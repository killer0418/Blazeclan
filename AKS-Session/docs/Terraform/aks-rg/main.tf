resource "azurerm_resource_group" "aks_rg" {
  name     = var.aks_rg_name
  location = var.aks_rg_location
}