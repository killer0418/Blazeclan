resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.firewall_policy_name
  resource_group_name = azurerm_resource_group.hub_rg.name
  location            = azurerm_resource_group.hub_rg.location
  sku                 = "Standard"
}

resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  firewall_policy_id  = azurerm_firewall_policy.firewall_policy.id
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  tags = var.default_tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.ip.id
  }
}

# resource "azurerm_firewall_application_rule_collection" "app" {
#   name                = "Appcollection1"
#   azure_firewall_name = azurerm_firewall.firewall.name
#   resource_group_name = azurerm_resource_group.rg.name
#   priority            = 100
#   action              = "Allow"

#   rule {
#     name = "rule1"
#     source_addresses = [
#       "${azurerm_subnet.spoke_subnet.address_prefixes.0}"
#     ]
#     target_fqdns = [
#       "*.google.com",
#     ]
#     protocol {
#       port = "443"
#       type = "Https"
#     }
#   }
# }

# resource "azurerm_firewall_nat_rule_collection" "nat" {
#   name                = "NATcollection1"
#   azure_firewall_name = azurerm_firewall.firewall.name
#   resource_group_name = azurerm_resource_group.rg.name
#   priority            = 200
#   action              = "Dnat"

#   rule {
#     name = "RDP"
#     source_addresses = [
#       "*",
#     ]
#     destination_ports = [
#       "3389",
#     ]
#     destination_addresses = [azurerm_public_ip.ip.ip_address]
#     translated_port    = 3389
#     translated_address = "8.8.8.8" //Application IP
#     protocols = ["TCP"]
#   }
# }