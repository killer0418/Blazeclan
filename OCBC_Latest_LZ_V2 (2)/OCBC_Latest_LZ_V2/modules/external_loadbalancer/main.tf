resource "azurerm_public_ip" "ip" {
  # provider = azurerm.NameOfSubscription
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rg_name
  sku = "Standard"

  frontend_ip_configuration {
    name = "frontend"
    public_ip_address_id = azurerm_public_ip.ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "backend"
}

# resource "azurerm_lb_backend_address_pool_address" "pool_address" {
#   name                                = "backend"
#   backend_address_pool_id             = azurerm_lb_backend_address_pool.pool.id
#   virtual_network_id = var.virtual_network_id
#   ip_address = var.ip_address
# }
resource "azurerm_lb_backend_address_pool_address" "pool_address_ext" {
  name                                = "backend_ext_A"
  backend_address_pool_id             = azurerm_lb_backend_address_pool.pool.id
  virtual_network_id = var.virtual_network_id
  ip_address = var.ip_address_ext
}

resource "azurerm_lb_backend_address_pool_address" "pool_address_ext1" {
  name                                = "backend_ext_B"
  backend_address_pool_id             = azurerm_lb_backend_address_pool.pool.id
  virtual_network_id = var.virtual_network_id
  ip_address = var.ip_address_ext1
}

resource "azurerm_lb_probe" "health_probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "ext_health_probe"
  protocol = "Tcp"
  port            = 22
  interval_in_seconds = 5
  number_of_probes = 1
}

resource "azurerm_lb_rule" "rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "ext_lb_rule"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  load_distribution = "SourceIPProtocol"
  frontend_ip_configuration_name = "frontend"
  probe_id = azurerm_lb_probe.health_probe.id
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.pool.id]
}
