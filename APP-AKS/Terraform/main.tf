provider "azurerm" {
  features {}
}

module "aks_rg" {
  source                           = "./aks-rg"
  aks_rg_name                      = var.aks_rg_name
  aks_rg_location                  = var.aks_rg_location
  
}

module "aks_vnet" {
  source                           = "./aks-vnet"
  aks_vnet_name                    = var.aks_vnet_name
  aks_vnet_address_space           = var.aks_vnet_address_space
  aks_rg_location                  = module.aks-rg.aks_rg_location
  aks_rg_name                      = module.aks-rg.aks_rg_name
  subnets_data                     = var.subnets_data
  network_profile                  = var.network_profile
  container_network_interface_name = var.container_network_interface_name
  ip_configuration_name            = var.ip_configuration_name
  
}

module "APP-AKS" {
    source                         = "./APP-AKS"
    aks_rg_name                    = module.aks-rg.aks_rg_name
    aks_rg_location                = module.aks-rg.aks_rg_location
    aks_name                       = var.aks_name
    node_pool_data                 = var.node_pool_data
    network_profile_data           = var.network_profile_data
    dns_prefix                     = var.dns_prefix  
    subnet_id = module.aks_vnet.aks_subnet_id
}

module "sql" {
  source                           = "./sql"
  sql_server_name                  = var.sql_server_name
  aks_rg_name                      = module.aks-rg.aks_rg_name
  aks_rg_location                  = module.aks-rg.aks_rg_location
  version                          = var.version
  administrator_login              = var.administrator_login
  administrator_login_password     = var.administrator_login_password
  sql_database_name                 = var.sql_database_name
}

module "private_endpoint" {
  source                           = "./privateendpoint"
  aks_rg_name                      = module.aks-rg.aks_rg_name
  aks_rg_location                  = module.aks_rg_location
  private_endpoint_name            = var.private_endpoint_name
  private_service_connection_name  = var.private_service_connection_name
  sql_subnet_id                    = module.aks-vnet.sql_subnet_id
  sql_server_id                    = module.sql.sql_server_id
  aks_vnet_id                      = module.aks-vnet.aks_vnet_id
}