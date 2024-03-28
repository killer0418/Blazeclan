
resource "azurerm_resource_group" "rg1" {

  name     = var.name_t2
  location = var.location
  tags     = var.tags_t2
}

