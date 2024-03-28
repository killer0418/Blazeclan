resource "azurerm_lb" "lb" {
  name                = var.lb_name
  # provider = azurerm.NameOfSubscription
  location            = var.location
  resource_group_name = var.rg_name
  sku = "Standard"
  sku_tier = "Regional"
  frontend_ip_configuration {
    name = "frontend"
    subnet_id = var.subnet_id
    private_ip_address = var.private_ip_address
    private_ip_address_version = "IPv4"
    private_ip_address_allocation = "Static"
  }
}

resource "azurerm_lb_backend_address_pool" "pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "backend_pool"
}

resource "azurerm_lb_backend_address_pool_address" "pool_address_int" {
  name                                = "backend_int"
  backend_address_pool_id             = azurerm_lb_backend_address_pool.pool.id
  virtual_network_id = var.virtual_network_id
  ip_address = var.ip_address_int
}
resource "azurerm_lb_backend_address_pool_address" "pool_address_int1" {
  name                                = "backend_int1"
  backend_address_pool_id             = azurerm_lb_backend_address_pool.pool.id
  virtual_network_id = var.virtual_network_id
  ip_address = var.ip_address_int1
}

# resource "azurerm_lb_backend_address_pool_address" "pool_address_ext" {
#   name                                = "backend_ext"
#   backend_address_pool_id             = azurerm_lb_backend_address_pool.pool.id
#   virtual_network_id = var.virtual_network_id
#   ip_address = var.ip_address_ext
# }

resource "azurerm_lb_probe" "health_probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "fw_health_probe"
  protocol = "Tcp"
  port            = 22
  interval_in_seconds = 5
  number_of_probes = 1
}

resource "azurerm_lb_rule" "rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "fw_lb_rule"
  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  frontend_ip_configuration_name = "frontend"
  probe_id = azurerm_lb_probe.health_probe.id
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.pool.id]
}
