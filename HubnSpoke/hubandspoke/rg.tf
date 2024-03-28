
resource "azurerm_resource_group" "hub_rg" {
provider            = azurerm.hub
  name     = var.hub_rg_name
  location = var.hub_location
  tags = var.default_tags
}

resource "azurerm_resource_group" "spoke_dev_rg" {
 provider            = azurerm.dev
  name     = var.spoke_dev_rg_name
  location = var.spoke_dev_location
  tags = var.default_tags
}

resource "azurerm_resource_group" "spoke_qa_rg" {
  provider            = azurerm.hub
  name     = var.spoke_qa_rg_name
  location = var.spoke_qa_location
  tags = var.default_tags
}

resource "azurerm_resource_group" "spoke_prod_rg" {
provider            = azurerm.dev
  name     = var.spoke_prod_rg_name
  location = var.spoke_prod_location
  tags = var.default_tags
}
