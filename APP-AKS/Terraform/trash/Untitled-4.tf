# resource "azurerm_kubernetes_cluster" "aks_cluster" {
#   name                = "myAKSCluster"
#   location            = azurerm_resource_group.aks_rg.location
#   resource_group_name = azurerm_resource_group.aks_rg.name
#   dns_prefix          = "myaksclusterdns"

#   default_node_pool {
#     count = length(var.node_pool_data)
#     name  = lookup(var.node_pool_data[count.index], "name")
#     node_count = lookup(var.node_pool_data[count.index], "node_count")
#     vm_size=lookup(var.node_pool_data[count.index]"vm_size")
#     vnet_subnet_id = azurerm_subnet.aks_subnet.id


#     # name       = "default"
#     # node_count = 1
#     # vm_size    = "Standard_DS2_v2"
#     # vnet_subnet_id = azurerm_subnet.aks_subnet.id
#   }

#   network_profile {
#     count = length(var.network_profile_data)
#     network_plugin =lookup(var.network_profile_data[count.index]"network_plugin")
#     dns_service_ip= lookup(var.network_profile_data[count.index]"dns_service_ip")
#     docker_bridge_cidr =lookup(var.network_profile_data[count.index]"docker_bridge_cidr")
#     service_cidr = lookup(var.network_profile_data[count.index]"service_cidr")
#     outbound_type= lookup(var.network_profile_data[count.index]"outbound_type")
#     # network_plugin     = "azure"
#     # dns_service_ip     = "10.0.0.10"
#     # docker_bridge_cidr = "172.17.0.1/16"
#     # service_cidr       = "10.0.0.0/16"
#     # outbound_type      = "userDefinedRouting"
#   }

#   #api_server_authorized_ip_ranges = [""] # Optional: Restrict API server access to a set of IP ranges

#   private_cluster_enabled = true

#   identity {
#     type = "SystemAssigned"
#   }

#   tags = {
#     Environment = "Development"
#   }
# }
