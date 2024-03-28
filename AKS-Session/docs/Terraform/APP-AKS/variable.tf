variable "aks_name" {
  
}
variable "dns_prefix" {
  
}
variable "node_pool_data" {
    type = list(object({
        name  = string
        node_count= string
        vm_size =string
  }))
}
  
variable "network_profile_data" {
   type = list(object({
        network_plugin = string
        dns_service_ip= string
        #docker_bridge_cidr=string
        service_cidr=string
        outbound_type =string
  }))
}
variable "aks_rg_name" {
  
}
variable "aks_rg_location" {
  
}
variable "subnet_id" {
  
}