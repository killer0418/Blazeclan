aks_rg_name = "aksResourceGroup"
     
aks_rg_location ="East US"   
  
aks_vnet_name =   "aksVNet"
   
aks_vnet_address_space =["10.0.0.0/8"]   
   
subnets_data =[
  {
    name             = "aks_subnet"
    address_prefixes = "10.6.1.0/24"
  },
  {
    name             = "sql_subnet"
    address_prefixes = "10.7.2.0/24"
  }
]
   
network_profile = {
    name             = "aks_network_profile"  
}
   
container_network_interface_name ="aksCni"   
   
ip_configuration_name    ="aksIpConfig"
   
aks_name             = "myAKSCluster"

dns_prefix           ="myaksclusterdns"
     
node_pool_data       = [{
   
                            name  = "default"
                            node_count= "1"
                            vm_size ="tandard_DS2_v2"
                       }] 
  
   
network_profile_data =[{
                            network_plugin     = "azure"
                            dns_service_ip     = "10.0.0.10"
                            service_cidr       = "10.0.0.0/16"
                            outbound_type      = "userDefinedRouting"
                      }]   
  
 
sql_server_name      ="aks_sql_server"

sql_database_name    ="aks_sql_database"
   
version              ="12.0"
   
administrator_login  ="sqladmin"   
   
administrator_login_password = "Yourpassword@123"  
   
private_endpoint_name =    "sql_private_endpoint"
  
private_service_connection_name ="sql-private-sql-connection"   
  
   