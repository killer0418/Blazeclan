resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  location                 = var.location
  resource_group_name      = var.rg_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
}

resource "azurerm_storage_container" "storeblob0rg" {
  name                  = var.blob_name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}



