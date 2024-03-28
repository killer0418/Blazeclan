# resource "azurerm_route_table" "route" {
#   name                          = var.routetable_name
#   location                      = var.location 
#   resource_group_name           = var.rg_name
#   disable_bgp_route_propagation = false

#   route {
#     name           = var.route_name #"route1"
#     address_prefix = var.address_prefix_route #"10.1.0.0/16"
#     next_hop_type  = var.next_hop_type #"VnetLocal" 
#     next_hop_in_ip_address = var.next_hop_in_ip_address
#   }

  
# }

# resource "azurerm_subnet_route_table_association" "example" {
#  count = length(var.subnet_ids)
#  subnet_id      = var.subnet_ids[count.index]
#  route_table_id = azurerm_route_table.route.id
# }