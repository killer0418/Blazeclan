resource "azurerm_lb" "lb" {
  name                = var.lb_name
# provider = azurerm.NameOfSubscription
  location            = var.location
  resource_group_name = var.rg_name
  sku = "Standard"
  sku_tier = "Regional"
  frontend_ip_configuration {
    name = "frontend_int"
    subnet_id = var.subnet_id_int
    private_ip_address = var.private_ip_address_int
    private_ip_address_version = "IPv4"
    private_ip_address_allocation = "Static"
  }
  frontend_ip_configuration {
    name = "frontend_ext"
    subnet_id = var.subnet_id_ext
    private_ip_address = var.private_ip_address_ext
    private_ip_address_version = "IPv4"
    private_ip_address_allocation = "Static"
  }
}

resource "azurerm_lb_backend_address_pool" "pool_int" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "backend_int_pool"
}

resource "azurerm_lb_backend_address_pool_address" "pool_address_int_A" {
  name                                = "backend_int_A"
  backend_address_pool_id             = azurerm_lb_backend_address_pool.pool_int.id
  virtual_network_id = var.virtual_network_id
  ip_address = var.ip_address_int_A
}

resource "azurerm_lb_backend_address_pool_address" "pool_address_int_B" {
  name                                = "backend_int_B"
  backend_address_pool_id             = azurerm_lb_backend_address_pool.pool_int.id
  virtual_network_id = var.virtual_network_id
  ip_address = var.ip_address_int_B
}

resource "azurerm_lb_backend_address_pool" "pool_ext" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "backend_ext_pool"
}

resource "azurerm_lb_backend_address_pool_address" "pool_address_ext_A" {
  name                                = "backend_ext_A"
  backend_address_pool_id             = azurerm_lb_backend_address_pool.pool_ext.id
  virtual_network_id = var.virtual_network_id
  ip_address = var.ip_address_ext_A
}

resource "azurerm_lb_backend_address_pool_address" "pool_address_ext_B" {
  name                                = "backend_ext_B"
  backend_address_pool_id             = azurerm_lb_backend_address_pool.pool_ext.id
  virtual_network_id = var.virtual_network_id
  ip_address = var.ip_address_ext_B
}

resource "azurerm_lb_probe" "health_probe_int" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "idps_health_probe_int"
  protocol = "Tcp"
  port            = 22
  interval_in_seconds = 5
  number_of_probes = 1
}

resource "azurerm_lb_rule" "rule_int" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "idps_lb_rule_int"
  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  frontend_ip_configuration_name = "frontend_int"
  probe_id = azurerm_lb_probe.health_probe_int.id
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.pool_int.id]
}

resource "azurerm_lb_probe" "health_probe_ext" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "idps_health_probe_ext"
  protocol = "Tcp"
  port            = 22
  interval_in_seconds = 5
  number_of_probes = 1
}

resource "azurerm_lb_rule" "rule_ext" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "idps_lb_rule_ext"
  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  frontend_ip_configuration_name = "frontend_ext"
  probe_id = azurerm_lb_probe.health_probe_ext.id
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.pool_ext.id]
}
