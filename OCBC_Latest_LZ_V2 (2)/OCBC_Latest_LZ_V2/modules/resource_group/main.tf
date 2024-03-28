

resource "azurerm_resource_group" "rg" {
  # provider = azurerm.NameOfSubscription
  name     = var.name
  location = var.location
  tags     = var.tags
}

