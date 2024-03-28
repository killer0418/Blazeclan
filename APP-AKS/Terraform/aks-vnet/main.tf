resource "azurerm_virtual_network" "aks_vnet" {
  name                = var.aks_vnet_name
  address_space       = var.aks_vnet_address_space
  location            = var.aks_rg.location
  resource_group_name = var.aks_rg_name
}

resource "azurerm_subnet" "aks_subnet" {
  count = length(var.subnets_data)
  name                = lookup(var.subnets_data[count.index], "name")
  #aks_subnet_namename                 = "aksSubnet"
  resource_group_name  = var.aks_rg_location
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  #aks_subnet_address_prefixes = ["10.240.0.0/16"]
  address_prefixes     = [lookup(var.subnets_data[count.index], "address_prefixes")]

  service_endpoints = ["Microsoft.AzureActiveDirectory", "Microsoft.ContainerRegistry", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Storage", "Microsoft.EventHub", "Microsoft.Web"]
}

resource "azurerm_network_profile" "aks_network_profile" {
  name                = lookup(var.network_profile[count.index],"aksNetworkProfile")
  location            = var.aks_rg_location
  resource_group_name = var.aks_rg_location

  container_network_interface {
    name = var.container_network_interface_name

    ip_configuration {
      name      = var.ip_configuration_name
      subnet_id = azurerm_subnet.aks_subnet.id
    }
  }
}