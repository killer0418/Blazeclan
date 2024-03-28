# resource "azurerm_resource_group" "sql" {
#   name     = "sql-resources"
#   location = "East US"
# }

# resource "azurerm_virtual_network" "sql" {
#   name                = "sql-vnet"
#   address_space       = ["10.5.0.0/16"]
#   location            = azurerm_resource_group.sql.location
#   resource_group_name = azurerm_resource_group.sql.name
# }

# resource "azurerm_subnet" "sql" {
#   count = length(var.subnets_data)
#   name                = lookup(var.subnets_data[count.index], "name")
#   #name                 = "sql-subnet"
#   resource_group_name  = azurerm_resource_group.sql.name
#   virtual_network_name = azurerm_virtual_network.sql.name
#   #address_prefixes     = ["10.5.1.0/24"]
#   address_prefixes     = [lookup(var.subnets_data[count.index], "address_prefixes")]
#   enforce_private_link_endpoint_network_policies = true
# }

# resource "azurerm_sql_server" "sql" {
#   name                         = "sqlsqlserver"
#   resource_group_name          = azurerm_resource_group.sql.name
#   location                     = azurerm_resource_group.sql.location
#   version                      = "12.0"
#   administrator_login          = "sqladmin"
#   administrator_login_password = "yourpassword123"

#   tags = {
#     environment = "production"
#   }
# }

# resource "azurerm_sql_database" "sql" {
#   name                = "sql-sqldb"
#   resource_group_name = azurerm_resource_group.sql.name
#   location            = azurerm_resource_group.sql.location
#   server_name         = azurerm_sql_server.sql.name

#   sku_name = "S0"

#   tags = {
#     environment = "production"
#   }
# }

# resource "azurerm_private_endpoint" "sql" {
#   name                = "sql-private-endpoint"
#   location            = azurerm_resource_group.sql.location
#   resource_group_name = azurerm_resource_group.sql.name
#   subnet_id           = azurerm_subnet.sql.id

#   private_service_connection {
#     name                           = "sql-private-sql-connection"
#     is_manual_connection           = false
#     private_connection_resource_id = azurerm_sql_server.sql.id
#     subresource_names              = ["sqlServer"]
#   }
# }

# resource "azurerm_private_dns_zone" "sql" {
#   name                = "privatelink.database.windows.net"
#   resource_group_name = azurerm_resource_group.sql.name
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "sql" {
#   name                  = "sql-dns-zone-link"
#   resource_group_name   = azurerm_resource_group.sql.name
#   private_dns_zone_name = azurerm_private_dns_zone.sql.name
#   virtual_network_id    = azurerm_virtual_network.sql.id
# }

# resource "azurerm_private_dns_a_record" "sql" {
#   name                = "sqlserver"
#   zone_name           = azurerm_private_dns_zone.sql.name
#   resource_group_name = azurerm_resource_group.sql.name
#   ttl                 = 300
#   records             = [azurerm_private_endpoint.sql.private_service_connection.0.private_ip_address]
# }

# output "private_endpoint_ip" {
#   value = azurerm_private_endpoint.sql.private_service_connection.0.private_ip_address
# }