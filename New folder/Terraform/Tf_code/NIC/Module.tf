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