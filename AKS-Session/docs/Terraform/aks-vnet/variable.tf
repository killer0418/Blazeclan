variable "aks_vnet_name" {
  
}
variable "aks_vnet_address_space" {
  
}
variable "aks_rg_name" {
  
}
variable "aks_rg_location" {
  
}
variable "container_network_interface_name" {
  
}
variable "ip_configuration_name" {
  
}
variable "subnets_data" {
  type = list(object({
        name  = string
        address_prefixes = string
  }))
}
variable "network_profile" {
    type = list(object({
        name  = string
  }))
}