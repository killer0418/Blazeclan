
resource "azurerm_resource_group" "rg2" {

  name     = var.name_app
  location = var.location
  tags     = var.tags_app
}

