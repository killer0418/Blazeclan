# Module Selection # If you don't want to run any module change the value to "false"
setazpolicy = false
backupvault = false
subscription = false
monitoring = false

# Monitoring = false
# network_interface = true
# resource_group = true
# virtual_machine = true
# vnet = true

#subscription Variables
billingac_id      = "msssjs"
enrollmentac_id   = "8726326781"
subscription_name = "new_sub"

subscription_ids           = {
    "NameOfSubscription" : "be510eed-cdc2-4632-9501-a44fe47aa346" ,#KeyIn the Subscription ID
    "NameOfSubscription1" : "27adeba3-f0dc-4d7e-ae23-3ccc9a73f37d"
}

vnet_peeername_app_hubT2 = "vnet_peering-app-hubT2"
vnet_peeername_hubT2_app  = "vnet_peering-hubT2-app"
vnet_peeername_app_hubT1 = "vnet_peering-app-hubT1"
vnet_peeername_hubT1_app  = "vnet_peering-hubT1-app"
#Resource Group 
rg_names = {
  "vnet" : "VNets",
  "vm" : "Virtual_Machines",
  "nics" : "Network_Interfaces",
  "lb" : "Load_Balancers",
  "monitoring" : "Monitoring",
  "backup" : "Backup"
}
rg_names_t2 = {
  "vnet" : "VNets",
  "vm" : "Virtual_Machines",
  "nics" : "Network_Interfaces",
  "lb" : "Load_Balancers",
  "monitoring" : "Monitoring",
  "backup" : "Backup"
}

rg_names_app = {
  "vnet" : "VNets",
  "vm" : "Virtual_Machines",
  "nics" : "Network_Interfaces",
  "lb" : "Load_Balancers",
  "monitoring" : "Monitoring",
  "backup" : "Backup"
}
#Location & Tags
location             = "eastus"
tags                 = { env = "T1" }
tags_t2              =  { env = "T2" }
tags_app             = {env = "app"}


actiongroup_name = "adminactiongroup"
actiongroup_shortname = "actiongrp"
email_receiver_name = "pritam havaldar"
email = "pritam.havaldar@blazeclan.com"
log_analytics_name = "wrkspace-newsisma2101"
dept_id = "12345678"
automationacct = "automationprit"
storage_account_name = "blazesprita01"
blob_name = "monitor"

#T1 VNET & SUBNETS
vnet_name_t1     = "Vnet_T1"
address_space_t1 = ["10.6.0.0/16"]
subnets_data_t1 = [
  {
    name             = "fw_subnet_A"
    address_prefixes = "10.6.1.0/24"
  },
  {
    name             = "fw_subnet_B"
    address_prefixes = "10.6.2.0/24"
  },
  {
    name             = "idps_subnet_A"
    address_prefixes = "10.6.3.0/24"
  },
  {
    name             = "idps_subnet_B"
    address_prefixes = "10.6.4.0/24"
  },
  {
    name             = "management_subnet"
    address_prefixes = "10.6.5.0/24"
  },
  {
    name             = "lb_subnet"
    address_prefixes = "10.6.6.0/24"
  }
]

#T2 VNET & SUBNETS
vnet_name_t2      = "Vnet_T2"
address_space_t2 = ["10.8.0.0/16"]
subnets_data_t2 = [
  {
    name             = "fw_A_subnet_t2"
    address_prefixes = "10.8.0.0/27"
  },
  {
    name             = "fw_B_subnet_t2"
    address_prefixes = "10.8.0.32/27"
  }
  # ,
  # {
  #   name             = "lb_subnet_t2"
  #   address_prefixes = "10.8.1.0/24"
  # }
]

vnet_name_app     = "Vnet_App"
address_space_app = ["10.7.0.0/16"]
subnets_data_app = [
  {
    name             = "app_subnet"
    address_prefixes = "10.7.0.0/24"
  }
]

delete_time-nic      = "600h"
create_option        = "Empty"
disk_size_gb         = "256"
disk_caching         = "ReadWrite"
storage_account_type = "Standard_LRS"

nic_properties_t2_A = [
  {
    name                          = "nic_T2fW_A1"
    ip_config_name                = "T2fW_A1"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.8.0.5"
  },
  {
    name                          = "nic_T2fW_A2"
    ip_config_name                = "T2fW_A2"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.8.0.6"
  },
  {
    name                          = "nic_T2fW_A3"
    ip_config_name                = "T2fW_A3"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.8.0.37"
  },
  {
    name                          = "nic_T2fW_A4"
    ip_config_name                = "T2fW_A4"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.8.0.38"
  }
]

nic_properties_t2_B = [
  {
    name                          = "nic_T2fW_B1"
    ip_config_name                = "T2fW_B1"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.8.0.39"
  },
  {
    name                          = "nic_T2fW_B2"
    ip_config_name                = "T2fW_B2"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.8.0.40"
  },
  {
    name                          = "nic_T2fW_B3"
    ip_config_name                = "T2fW_B3"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.8.0.7"
  },
  {
    name                          = "nic_T2fW_B4"
    ip_config_name                = "T2fW_B4"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.8.0.8"
  }
]

nic_properties_fw_A = [
  {
    name                          = "nic_T1fW_A1"
    ip_config_name                = "T1fW_A1"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.1.4"
  },
  {
    name                          = "nic_T1fW_A2"
    ip_config_name                = "T1fW_A2"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.2.4"
  },
  {
    name                          = "nic_T1fW_A3"
    ip_config_name                = "T1fW_A3"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.5.4"
  },
  {
    name                          = "nic_T1fW_A4"
    ip_config_name                = "T1fW_A4"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.6.4"
  }
]

nic_properties_fw_B = [
  {
    name                          = "nic_T1fw_B1"
    ip_config_name                = "T1fw_B1"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.1.5"
  },
  {
    name                          = "nic_T1fw_B2"
    ip_config_name                = "T1fw_B2"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.2.5"
  },
  {
    name                          = "nic_T1fw_B3"
    ip_config_name                = "T1fw_B3"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.5.5"
  },
  {
    name                          = "nic_T1fw_B4"
    ip_config_name                = "T1fw_B4"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.6.5"
  }
]

nic_properties_idps_A = [

  {
    name                          = "nic_IDPS_A1"
    ip_config_name                = "IDPS_A1"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.3.4"
  },
  {
    name                          = "nic_IDPS_A2"
    ip_config_name                = "IDPS_A2"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.4.4"
  },
  
  {
    name                          = "nic_IDPS_A3"
    ip_config_name                = "IDPS_A3"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.5.6"
  },
  {
    name                          = "nic_IDPS_A4"
    ip_config_name                = "IDPS_A4"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.6.6"
  }
]

nic_properties_idps_B = [
  {
    name                          = "nic_IDPS_B1"
    ip_config_name                = "IDPS_B1"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.3.5"
  },
  {
    name                          = "nic_IDPS_B2"
    ip_config_name                = "IDPS_B2"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.4.5"
  },
  {
    name                          = "nic_IDPS_B3"
    ip_config_name                = "IDPS_B3"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.5.7"
  },
  {
    name                          = "nic_IDPS_B4"
    ip_config_name                = "IDPS_B4"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.6.6.7"
  }
]

nsg_name_t2_A = "fw_t2_A_nsg"
nsg_name_t2_B = "fw_t2_B_nsg"
nsg_name_fw_A = "fw_t1_A_nsg"
nsg_name_fw_B = "fw_t1_B_nsg"
nsg_name_idps_A = "idps_A_nsg"
nsg_name_idps_B = "idps_B_nsg"

#t2 Loadbalancer VM  markateplace variables
size_t2      = "Standard_D3_v2"
publisher_t2 = "cognosys"
offer_t2     = "centos-8-3-free"
sku_t2       = "centos-8-3-free"
version_t2   = "latest"

vm_name_t2_A        = "mosccaxntt1ltm01-N"
admin_username_t2_A = "azadmin"
admin_password_t2_A = "P@$$w0rd1234!"

vm_name_t2_B        = "mosccaxntt1ltm02-N"
admin_username_t2_B = "azadmin"
admin_password_t2_B = "P@$$w0rd1234!"

#fW (Polo-Alto)  VM  markateplace variables
size_fw      = "Standard_A4_v2"
publisher_fw = "cognosys"
offer_fw     = "centos-8-3-free"
sku_fw       = "centos-8-3-free"
version_fw   = "latest"

vm_name_fw_A        = "mosccaxntt1fw0a-N"
admin_username_fw_A = "azadmin"
admin_password_fw_A = "P@$$w0rd1234!"

vm_name_fw_B        = "mosccaxntt1fw0b-N"
admin_username_fw_B = "azadmin"
admin_password_fw_B = "P@$$w0rd1234!"

#IDPS VM markateplace variables
size_idps      = "Standard_B4ms"
publisher_idps = "cognosys"
offer_idps     = "centos-8-3-free"
sku_idps       = "centos-8-3-free"
version_idps   = "latest"

vm_name_idps_A        = "mosccaxntt1idps0a-N"
admin_username_idps_A = "azadmin"
admin_password_idps_A = "P@$$w0rd1234!"

vm_name_idps_B        = "mosccaxntt1idps0b-N"
admin_username_idps_B = "azadmin"
admin_password_idps_B = "P@$$w0rd1234!"

public_ip_name = "ext_pip"
lb_name_ext = "Ext_LB"
# ip_address_ext = "10.57.13.41"
ip_address_ext_fwA = "10.6.1.4"
ip_address_ext_fwB = "10.6.1.5"

lb_name_fw = "T1_FW_LB"
private_ip_address_fw = "10.6.2.6"
ip_address_int_fwA = "10.6.2.4"
ip_address_int_fwB  = "10.6.2.5"

lb_name_idps = "T1_IDPS_LB"
private_ip_address_int_idps = "10.6.4.6"
private_ip_address_ext_idps = "10.6.3.6"
ip_address_int_idps_A = "10.6.4.4"
ip_address_int_idps_B = "10.6.4.5"
ip_address_ext_idps_A = "10.6.3.4"
ip_address_ext_idps_B = "10.6.3.5"

#backup vault
vaultname  = "blazevault01"
backuppolicyname = "dataprotectpolicy3"

#rutetable
route_name = "apptot1"
routetable_name = "new routetaable"
address_prefix_route = "0.0.0.0/0"
next_hop_type = "VirtualAppliance"
next_hop_in_ip_address = "10.6.3.0/24"

route_name1 = "apptot2"
routetable_name1 = "new routetaablet2"
address_prefix_route1 = "0.0.0.0/0"
next_hop_type1 = "VirtualAppliance"
next_hop_in_ip_address1 = "10.6.3.0/24"