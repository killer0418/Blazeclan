# provider "azurerm" {
#   features {}
#   alias = "DCC-Azure-Pritam" #enter subscription name 
#   subscription_id = "27adeba3-f0dc-4d7e-ae23-3ccc9a73f37d" #KeyIn the Subscription ID
# }

# provider "azurerm" {
#   features {}
#   alias = "NameOfSubscription" #enter subscription name 
#   subscription_id = "be510eed-cdc2-4632-9501-a44fe47aa346" #KeyIn the Subscription ID
# }
module "vnetpeer_hubT1_app" {
source = "./modules/Vnetpeering"
providers = {
  azurerm = azurerm.NameOfSubscription
  
 }
  vnet_peername = var.vnet_peeername_hubT1_app
  vnet_rg = var.rg_names.vnet
  vnet_name = module.vnet_t1.virtual_network_name
  virtual_network_ids = module.vnet_app.virtual_network_id
  depends_on = [
    module.vnet_t1, module.vnet_app , module.resource_group
  
  ]
}
module "vnetpeer_app_hubT1" {
source = "./modules/Vnetpeering"
providers = {
  azurerm = azurerm.NameOfSubscription2
  
 }
  vnet_peername = var.vnet_peeername_app_hubT1
  vnet_rg = var.rg_names_app.vnet
  vnet_name = module.vnet_app.virtual_network_name
  virtual_network_ids = module.vnet_t1.virtual_network_id
  depends_on = [
    module.vnet_t1, module.vnet_app , module.resource_group_app
  ]
}
module "vnetpeer_hubT2_app" {
source = "./modules/Vnetpeering"
providers = {

  azurerm = azurerm.NameOfSubscription1
 }
  vnet_peername = var.vnet_peeername_hubT2_app
  vnet_rg = var.rg_names_t2.vnet
  vnet_name = module.vnet_t2.virtual_network_name
  virtual_network_ids = module.vnet_app.virtual_network_id
  depends_on = [
    module.vnet_t2, module.vnet_app, module.resource_group_t2
  ]
}
module "vnetpeer_app_hubT2" {
source = "./modules/Vnetpeering"
providers = {
  
  azurerm = azurerm.NameOfSubscription2
 }
  vnet_peername = var.vnet_peeername_app_hubT2
  vnet_rg = var.rg_names_app.vnet
  vnet_name = module.vnet_app.virtual_network_name
  virtual_network_ids = module.vnet_t2.virtual_network_id
  depends_on = [
    module.vnet_t2, module.vnet_app, module.resource_group_app
  ]
}


module "monitoring" {
  source = "./modules/monitoring"
  count = var.monitoring ? 1 : 0
  rg_name = var.rg_names.monitoring
  location = var.location
  actiongroup_name = var.actiongroup_name
  actiongroup_shortname = var.actiongroup_shortname
  email_receiver_name = var.email_receiver_name
  email = var.email
  log_analytics_name = var.log_analytics_name
  dept_id = var.dept_id
  automationacct = var.automationacct
  storage_account_name = var.storage_account_name
  blob_name = var.blob_name
  depends_on = [module.resource_group]
}

module "setazpolicy" {
  source = "./modules/policy"
  count = var.setazpolicy ? 1 : 0
  #managementid = module.managementgroup_create.managementid
  managementid = "cdeeaf27-e775-4cc0-820c-9085b7132c1d"
  workspace_id = module.monitoring.0.loganaltyicsid
  backup_policy_id = module.backupvault.0.backupvmpolicy
  location = var.location 
  listOfAllowedLocations = ["southeastasia", "eastasia", "eastus"]
  listOfAllowedSKUs = [ "Standard_A1", "Standard_A2", "Standard_A4", "Standard_B2s", "Standard_D3_v2", "Standard_A4_v2", "Standard_B4ms"]
  listOfResourceTypesNotAllowed = [ "Microsoft.ClassicCompute", "Microsoft.ClassicNetwork", "Microsoft.ClassicStorage", "Microsoft.ClassicSubscription ", "ClassicInfrastructureMigrate" ]
  listOFAllowedStoreSKU = [ "Standard general-purpose v2", "Standard general-purpose v1", "Standard Blob storage", "Standard_LRS" ]
  tag_value = "Production"
  costcentertagname = "Cost"
  costcentertagvalue = "$$"
  depends_on = [module.backupvault]
}

# module "routetablet1" {
#   source = "./modules/routetable"
#   routetable_name = var.routetable_name
#   route_name = var.route_name
#   location =  var.location
#   rg_name = var.rg_names.vnet
#   address_prefix_route = var.address_prefix_route
#   next_hop_type = var.next_hop_type
#   subnet_ids      = [module.vnet_t1.subnet_id[0]]
#   next_hop_in_ip_address = var.next_hop_in_ip_address
#    depends_on = [
#     module.resource_group
#   ]
# }

# module "routetablet2" {
#   source = "./modules/routetable"
#   routetable_name = var.routetable_name1
#   route_name = var.route_name1
#   location =  var.location
#   rg_name = var.rg_names.vnet
#   address_prefix_route = var.address_prefix_route
#   next_hop_type = var.next_hop_type
#   subnet_ids      = [module.vnet_t2.subnet_id[0]]
#   next_hop_in_ip_address = var.next_hop_in_ip_address
#    depends_on = [
#     module.resource_group
#   ]
# }
module "backupvault" {
  source = "./modules/backup"
  count = var.backupvault ? 1 : 0 
  vaultname = var.vaultname
  backuppolicyname = var.backuppolicyname
  rg_name = var.rg_names.backup
  location = var.location
  depends_on = [module.resource_group]
}

module "resource_group" {
  source   = "./modules/resource_group"
  providers = {
    azurerm = azurerm.NameOfSubscription
   }
  for_each = var.rg_names
  name     = each.value
  location = var.location
  tags     = var.tags
}


module "resource_group_t2" {
  source   = "./modules/resource_group_t2"
  providers = {
    azurerm = azurerm.NameOfSubscription1
   }
  for_each = var.rg_names_t2
  name_t2      = each.value
  location = var.location
  tags_t2     = var.tags_t2
}

module "resource_group_app" {
  source   = "./modules/resource_group_app"
  providers = {
    azurerm = azurerm.NameOfSubscription2
   }
  for_each = var.rg_names_app
  name_app      = each.value
  location = var.location
  tags_app     = var.tags_app
}


module "nic_t2_A" {
  source          = "./modules/network_interface_t2"
  nic_properties  = toset(var.nic_properties_t2_A)
  providers = {
    azurerm = azurerm.NameOfSubscription1
   }
  location        = var.location
  nic_rg_name     = var.rg_names.nics
  delete_time-nic = var.delete_time-nic
  subnet_ids      = [module.vnet_t2.subnet_id[0], module.vnet_t2.subnet_id[0], module.vnet_t2.subnet_id[1], module.vnet_t2.subnet_id[1]]
  nsg_name = var.nsg_name_t2_A
  tags            = var.tags_t2
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "nic_t2_B" {
  source          = "./modules/network_interface_t2"
providers = {
    azurerm = azurerm.NameOfSubscription1
   }
  nic_properties  = var.nic_properties_t2_B
  location        = var.location
  nic_rg_name     = var.rg_names.nics
  delete_time-nic = var.delete_time-nic
  subnet_ids      = [module.vnet_t2.subnet_id[1], module.vnet_t2.subnet_id[1], module.vnet_t2.subnet_id[0], module.vnet_t2.subnet_id[0]]
  nsg_name = var.nsg_name_t2_B
  tags            = var.tags_t2
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "nic_fw_A" {
  source          = "./modules/network_interface"
  providers = {
    azurerm = azurerm.NameOfSubscription
   }

  nic_properties  = var.nic_properties_fw_A
  location        = var.location
  nic_rg_name     = var.rg_names.nics
  delete_time-nic = var.delete_time-nic
  subnet_ids      = [module.vnet_t1.subnet_id[0], module.vnet_t1.subnet_id[1], module.vnet_t1.subnet_id[4], module.vnet_t1.subnet_id[5]]
  nsg_name = var.nsg_name_fw_A
  tags            = var.tags
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "nic_fw_B" {
  source          = "./modules/network_interface"
providers = {
    azurerm = azurerm.NameOfSubscription
   }
  nic_properties  = var.nic_properties_fw_B
  location        = var.location
  nic_rg_name     = var.rg_names.nics
  delete_time-nic = var.delete_time-nic
  subnet_ids      = [module.vnet_t1.subnet_id[0], module.vnet_t1.subnet_id[1], module.vnet_t1.subnet_id[4], module.vnet_t1.subnet_id[5]]
  nsg_name = var.nsg_name_fw_B
  tags            = var.tags
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "nic_idps_A" {
  source          = "./modules/network_interface"
  providers = {
    azurerm = azurerm.NameOfSubscription
   }

  nic_properties  = var.nic_properties_idps_A
  location        = var.location
  nic_rg_name     = var.rg_names.nics
  delete_time-nic = var.delete_time-nic
  subnet_ids      = [module.vnet_t1.subnet_id[2], module.vnet_t1.subnet_id[3], module.vnet_t1.subnet_id[4], module.vnet_t1.subnet_id[5]]
  nsg_name = var.nsg_name_idps_A
  tags            = var.tags
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "nic_idps_B" {
  source          = "./modules/network_interface"
providers = {
    azurerm = azurerm.NameOfSubscription
   }
  nic_properties  = var.nic_properties_idps_B
  location        = var.location
  nic_rg_name     = var.rg_names.nics
  delete_time-nic = var.delete_time-nic
  subnet_ids      = [module.vnet_t1.subnet_id[2], module.vnet_t1.subnet_id[3], module.vnet_t1.subnet_id[4], module.vnet_t1.subnet_id[5]]
  nsg_name = var.nsg_name_idps_B
  tags            = var.tags
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "t2_A" {
  source               = "./modules/virtual_machine_t2"
  providers = {
    azurerm = azurerm.NameOfSubscription1
   }
  vm_name_t2              = var.vm_name_t2_A
  vm_rg_name_t2         = var.rg_names.vm
  location             = var.location
  vm_size_t2              = var.size_t2
  admin_username_t2      = var.admin_username_t2_A
  admin_password_t2      = var.admin_password_t2_A
  nic_ids_t2           = module.nic_t2_A.nic_ids
  disk_caching_t2         = var.disk_caching
  storage_account_type_t2 = var.storage_account_type
  publisher_t2            = var.publisher_t2
  offer_t2                = var.offer_t2
  sku_t2                  = var.sku_t2
  vm_version_t2           = var.version_t2
  zone_t2                 = 1
  create_option_t2        = var.create_option
  disk_size_gb_t2         = var.disk_size_gb
  tags_t2                 = var.tags_t2
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "t2_B" {
  source               = "./modules/virtual_machine_t2"
providers = {
    azurerm = azurerm.NameOfSubscription1
   }
  vm_name_t2              = var.vm_name_t2_B
  vm_rg_name_t2           = var.rg_names.vm
  location                = var.location
  vm_size_t2              = var.size_t2
  admin_username_t2       = var.admin_username_t2_A
  admin_password_t2       = var.admin_password_t2_A
  nic_ids_t2              = module.nic_t2_B.nic_ids
  disk_caching_t2         = var.disk_caching
  storage_account_type_t2 = var.storage_account_type
  publisher_t2            = var.publisher_t2
  offer_t2                = var.offer_t2
  sku_t2                  = var.sku_t2
  vm_version_t2           = var.version_t2
  zone_t2                 = 2
  create_option_t2        = var.create_option
  disk_size_gb_t2         = var.disk_size_gb
  tags_t2                 = var.tags
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "fw_A" {
  source               = "./modules/virtual_machine"
  providers = {
    azurerm = azurerm.NameOfSubscription
   }
  vm_name              = var.vm_name_fw_A
  vm_rg_name           = var.rg_names.vm
  location             = var.location
  vm_size              = var.size_fw
  admin_username       = var.admin_username_fw_A
  admin_password       = var.admin_password_fw_A
  nic_ids              = module.nic_fw_A.nic_ids
  disk_caching         = var.disk_caching
  storage_account_type = var.storage_account_type
  publisher            = var.publisher_fw
  offer                = var.offer_fw
  sku                  = var.sku_fw
  vm_version           = var.version_fw
  zone                 = 1
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb
  tags                 = var.tags
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "fw_B" {
  source               = "./modules/virtual_machine"
  providers = {
    azurerm = azurerm.NameOfSubscription
   }
  vm_name              = var.vm_name_fw_B
  vm_rg_name           = var.rg_names.vm
  location             = var.location
  vm_size              = var.size_fw
  admin_username       = var.admin_username_fw_B
  admin_password       = var.admin_password_fw_B
  nic_ids              = module.nic_fw_B.nic_ids
  disk_caching         = var.disk_caching
  storage_account_type = var.storage_account_type
  publisher            = var.publisher_fw
  offer                = var.offer_fw
  sku                  = var.sku_fw
  vm_version           = var.version_fw
  zone                 = 2
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb
  tags                 = var.tags
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "idps_A" {
  source               = "./modules/virtual_machine"
  providers = {
    azurerm = azurerm.NameOfSubscription
   }
  vm_name              = var.vm_name_idps_A
  vm_rg_name           = var.rg_names.vm
  location             = var.location
  vm_size              = var.size_idps
  admin_username       = var.admin_username_idps_A
  admin_password       = var.admin_password_idps_A
  nic_ids              = module.nic_idps_A.nic_ids
  disk_caching         = var.disk_caching
  storage_account_type = var.storage_account_type
  publisher            = var.publisher_idps
  offer                = var.offer_idps
  sku                  = var.sku_idps
  vm_version           = var.version_idps
  zone                 = 1
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb
  tags                 = var.tags
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "idps_B" {
  source               = "./modules/virtual_machine"
providers = {
    azurerm = azurerm.NameOfSubscription
   }
  vm_name              = var.vm_name_idps_B
  vm_rg_name           = var.rg_names.vm
  location             = var.location
  vm_size              = var.size_idps
  admin_username       = var.admin_username_idps_B
  admin_password       = var.admin_password_idps_B
  nic_ids              = module.nic_idps_B.nic_ids
  disk_caching         = var.disk_caching
  storage_account_type = var.storage_account_type
  publisher            = var.publisher_idps
  offer                = var.offer_idps
  sku                  = var.sku_idps
  vm_version           = var.version_idps
  zone                 = 2
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb
  tags                 = var.tags
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

#-------------------------subacription creation--------------- 
module "subscription" {
  source            = "./modules/subscription"
  count             = var.subscription ? 1 : 0 
  billingac_id      = var.billingac_id
  enrollmentac_id   = var.enrollmentac_id
  subscription_name = var.subscription_name
}

module "vnet_t1" {
  
  source        = "./modules/vnet"
providers = {
    azurerm = azurerm.NameOfSubscription
   }
  vnet_name     = var.vnet_name_t1
  rg_name       = var.rg_names.vnet
  location      = var.location
  address_space = var.address_space_t1
  subnets_data  = var.subnets_data_t1
  tags          = var.tags
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "vnet_t2" {
  source        = "./modules/vnet_t2"
providers = {
    azurerm = azurerm.NameOfSubscription1
   }
  # provider = var.providers.DCC-Azure-Pritam
  vnet_name_t2     = var.vnet_name_t2
  rg_name_t2       = var.rg_names.vnet
  location      = var.location
  address_space_t2 = var.address_space_t2
  subnets_data_t2  = var.subnets_data_t2
  tags_t2          = var.tags_t2
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "vnet_app" {
  source        = "./modules/vnet"
  providers = {
    azurerm = azurerm.NameOfSubscription2
   }
  vnet_name     = var.vnet_name_app
  rg_name      = var.rg_names.vnet
  location      = var.location
  address_space = var.address_space_app
  subnets_data  = var.subnets_data_app
  tags       = var.tags
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "ext_lb" {
  source                = "./modules/external_loadbalancer"
  providers = {
    azurerm = azurerm.NameOfSubscription
   }
  public_ip_name        = var.public_ip_name
  location              = var.location
  rg_name               = var.rg_names.lb
  lb_name               = var.lb_name_ext
  virtual_network_id    = module.vnet_t1.virtual_network_id
  ip_address_ext = var.ip_address_ext_fwA
  ip_address_ext1 = var.ip_address_ext_fwB
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "fw_lb" {
  source                = "./modules/fw_loadbalancer"
  providers = {
    azurerm = azurerm.NameOfSubscription
   }
  location              = var.location
  rg_name               = var.rg_names.lb
  lb_name               = var.lb_name_fw
  private_ip_address = var.private_ip_address_fw
  subnet_id = module.vnet_t1.subnet_id[1]
  virtual_network_id    = module.vnet_t1.virtual_network_id
  ip_address_int = var.ip_address_int_fwA
  ip_address_int1 = var.ip_address_int_fwB
  # 
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

module "idps_lb" {
  source                = "./modules/idps_loadbalancer"
providers = {
    azurerm = azurerm.NameOfSubscription
   }
  location              = var.location
  rg_name               = var.rg_names.lb
  lb_name               = var.lb_name_idps
  virtual_network_id    = module.vnet_t1.virtual_network_id
  subnet_id_int = module.vnet_t1.subnet_id[3]
  subnet_id_ext = module.vnet_t1.subnet_id[2]
  private_ip_address_int = var.private_ip_address_int_idps
  private_ip_address_ext = var.private_ip_address_ext_idps
  ip_address_int_A = var.ip_address_int_idps_A
  ip_address_int_B = var.ip_address_int_idps_B
  ip_address_ext_A = var.ip_address_ext_idps_A
  ip_address_ext_B = var.ip_address_ext_idps_B
  depends_on = [
    module.resource_group, module.setazpolicy
  ]
}

# module "t2_lb" {
#   source                = "./modules/idps_loadbalancer"
#   location              = var.location
#   rg_name               = var.rg_names.lb
#   lb_name               = var.lb_name
#   virtual_network_id    = module.vnet.virtual_network_id
#   subnet_id_int = 
#   subnet_id_ext = 
#   private_ip_address_int = 
#   private_ip_address_ext =  
#   ip_address_int_A = 
#   ip_address_int_B = 
#   ip_address_ext_A = 
#   ip_address_ext_B = 
#   depends_on = [
#     module.resource_group, module.setazpolicy
#   ]
# }

