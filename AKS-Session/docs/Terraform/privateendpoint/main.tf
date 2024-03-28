resource "azurerm_private_endpoint" "sql" {
  name                = var.private_endpoint_name
  location            = var.aks_rg_location
  resource_group_name = var.aks_rg_name
  subnet_id           = var.sql_subnet_id

  private_service_connection {
    name                           = var.private_service_connection_name
    is_manual_connection           = false
    private_connection_resource_id = var.sql_server_id
    subresource_names              = ["sqlServer"]
  }
}

resource "azurerm_private_dns_zone" "sql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.aks_rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql" {
  name                  = "sql-dns-zone-link"
  resource_group_name   = var.aks_rg_name
  private_dns_zone_name = azurerm_private_dns_zone.sql.name
  virtual_network_id    = var.aks_vnet_id
}

resource "azurerm_private_dns_a_record" "sql" {
  name                = "sqlserver"
  zone_name           = azurerm_private_dns_zone.sql.name
  resource_group_name = var.aks_rg_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.sql.private_service_connection.0.private_ip_address]
}