resource "azurerm_public_ip" "ip" {
  provider            = azurerm.hub
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.hub_rg.name
  location            = azurerm_resource_group.hub_rg.location
  sku                 = "Standard"
  allocation_method   = "Static"
  tags = var.default_tags
}