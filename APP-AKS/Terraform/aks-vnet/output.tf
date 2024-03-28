output "aks_subnet_id" {
  value = azurerm_subnet.aks_subnet.id
}
output "sql_subnet_name" {
  value = azurerm_subnet.sql_subnet.id
  
}
output "vnet_id" {
    value = azurerm_subnet.aks_vnet.id
  
}
output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}