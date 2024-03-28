############################  If the Spoke Vnets are from Same Region Use the below Code ##################################

# resource "azurerm_route_table" "route_table" {
#   name                          = var.route_table_name
#   location                      = azurerm_resource_group.hub_rg.location
#   resource_group_name           = azurerm_resource_group.hub_rg.name
#   disable_bgp_route_propagation = false

#   route {
#     name                   = "route1"
#     address_prefix         = azurerm_virtual_network.vnet_hub.address_space.0
#     next_hop_type          = "VirtualAppliance"
#     next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration.0.private_ip_address
#   }
# }

# resource "azurerm_subnet_route_table_association" "route_subnet_dev" {
#   subnet_id      = azurerm_subnet.spoke_dev_subnet.id
#   route_table_id = azurerm_route_table.route_table.id
# }

# resource "azurerm_subnet_route_table_association" "route_subnet_qa" {
#   subnet_id      = azurerm_subnet.spoke_qa_subnet.id
#   route_table_id = azurerm_route_table.route_table.id
# }

# resource "azurerm_subnet_route_table_association" "route_subnet_prod" {
#   subnet_id      = azurerm_subnet.spoke_prod_subnet.id
#   route_table_id = azurerm_route_table.route_table.id
# }


############################  If the Spoke Vnets are from Different Regions Use the below Code ##################################

# resource "azurerm_route_table" "route_table_dev" {
#   provider            = azurerm.hub
#   name                          = var.route_table_dev_name
#   location                      = azurerm_resource_group.spoke_dev_rg.location
#   resource_group_name           = azurerm_resource_group.hub_rg.name
#   disable_bgp_route_propagation = false

#   route {
#     name                   = "route_dev"
#     address_prefix         = azurerm_virtual_network.vnet_spoke_dev.address_space.0
#     next_hop_type          = "VirtualAppliance"
#     next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration.0.private_ip_address
#   }
# }

# resource "azurerm_subnet_route_table_association" "route_subnet_dev" {
#   provider   = azurerm.hub
#   subnet_id      = azurerm_subnet.spoke_dev_subnet.id
#   route_table_id = azurerm_route_table.route_table_dev.id
#   depends_on = [
#     azurerm_resource_group.spoke_dev_rg
#   ]
# }

resource "azurerm_route_table" "route_table_qa" {
  provider            = azurerm.hub
  name                          = var.route_table_qa_name
  location                      = azurerm_resource_group.spoke_qa_rg.location
  resource_group_name           = azurerm_resource_group.hub_rg.name
  disable_bgp_route_propagation = false

  route {
    name                   = "route_qa"
    address_prefix         = azurerm_virtual_network.vnet_spoke_qa.address_space.0
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration.0.private_ip_address
  }
}
resource "azurerm_subnet_route_table_association" "route_subnet_qa" {
  provider   = azurerm.hub 
  subnet_id      =  azurerm_subnet.spoke_qa_subnet.id
  route_table_id = azurerm_route_table.route_table_qa.id
  depends_on = [
    azurerm_resource_group.spoke_qa_rg
  ]
}

# resource "azurerm_route_table" "route_table_prod" {
#   provider            = azurerm.hub
#   name                          = var.route_table_prod_name
#   location                      = azurerm_resource_group.spoke_prod_rg.location
#   resource_group_name           = azurerm_resource_group.hub_rg.name
#   disable_bgp_route_propagation = false

#   route {
#     name                   = "route_prod"
#     address_prefix         = azurerm_virtual_network.vnet_spoke_prod.address_space.0
#     next_hop_type          = "VirtualAppliance"
#     next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration.0.private_ip_address
#   }
# }
# resource "azurerm_subnet_route_table_association" "route_subnet_prod" {
# provider   = azurerm.hub
#  subnet_id      =  azurerm_subnet.spoke_prod_subnet.id
#  route_table_id = azurerm_route_table.route_table_prod.id
#  depends_on = [
#    azurerm_resource_group.spoke_prod_rg
#  ]
# }