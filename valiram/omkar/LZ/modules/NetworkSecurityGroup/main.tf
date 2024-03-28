resource "azurerm_network_security_group" "nsg" {
  name = var.nsgName
  location = var.nsgLocation
  resource_group_name = var.nsgRG
  
    security_rule  {
    name                       = "DenyALLInbound"
    priority                   = "4000"
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
   }
}

  
   
