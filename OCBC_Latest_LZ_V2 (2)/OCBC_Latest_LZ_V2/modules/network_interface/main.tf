

resource "azurerm_network_interface" "nic" {
  count = length(var.subnet_ids)
  name                = lookup(var.nic_properties[count.index], "name")
  # provider = azurerm.NameOfSubscription
  location            = var.location
  resource_group_name = var.nic_rg_name
  timeouts {
    delete = var.delete_time-nic
  }
  ip_configuration {
    name                          = lookup(var.nic_properties[count.index], "ip_config_name")
    subnet_id                     = var.subnet_ids[count.index]
    private_ip_address_allocation = lookup(var.nic_properties[count.index], "private_ip_address_allocation")
    private_ip_address            = lookup(var.nic_properties[count.index], "private_ip_address")
  }
  tags = var.tags
}

resource "azurerm_network_security_group" "nsg" {
  name            = var.nsg_name
  location            = var.location
  resource_group_name = var.nic_rg_name

  security_rule {
    name                       = "AllowAnySSHInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  count = length(var.subnet_ids)
  subnet_id                     = var.subnet_ids[count.index]
  # network_interface_id      = azurerm_network_interface.nic.0.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}