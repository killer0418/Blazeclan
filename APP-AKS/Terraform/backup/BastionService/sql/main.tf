resource "azurerm_sql_server" "sql" {
  name                         = var.sql_server_name
  resource_group_name          = var.aks_rg_name
  location                     = var.aks_rg_location
  version                      = var.version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  tags = {
    environment = "production"
  }
}
resource "azurerm_sql_database" "sql" {
  name                = var.sql_database_name
  resource_group_name = var.aks_rg_name
  location            = var.aks_rg_location
  server_name         = azurerm_sql_server.sql.name
  #sku_name = "S0"

  tags = {
    environment = "production"
  }
}