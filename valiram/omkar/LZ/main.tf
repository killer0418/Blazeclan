#Platform Subscription
module "ResourceGroup" {
  source = "./modules/ResourceGroup"
  #count= var.ResourceGroup==true ?1:0
  providers = {
    azurerm  = azurerm.DCCAzure-Omkar
  }
  for_each = var.rg_platform             # Change value 
  name = each.value
  location = var.location
  tags = var.tags
}

module "VirtualNetwork" {
  source = "./modules/VirtualNetwork"
  providers = {
    azurerm = azurerm.DCCAzure-Omkar
  }
  vnet_name = var.platformVNet_name
  rg_name = var.rg_platform.rg-connectivity-mgmt-ea-01
  location = var.location
  address_space = var.platformAddSpace
  #subnet_name_A= var.plat_conn_subA
  #subnet_name_B= var.plat_conn_subB
  #address_prefixes_A = var.GwSubaddprefix
  #address_prefixes_B = var.FWSubaddprefix
  tags = var.tags
  depends_on = [ module.ResourceGroup ]
}

#Corp Subscription

module "ResourceGroupCorp" {
  source = "./modules/ResourceGroup"
  #count= var.ResourceGroup==true ?1:0
  providers = {
    azurerm  = azurerm.DCC-Azure-Pritam
  }
  for_each = var.rg_corp            # Change value 
  name=each.value
  location = var.location
  tags = var.tags
}

module "VirtualNetworkCorp" {
  source = "./modules/VirtualNetwork"
  providers = {
    azurerm = azurerm.DCC-Azure-Pritam # Change value 
  }
  vnet_name = var.corpVNet_name
  rg_name = var.rg_corp.rg-corp-vnet-ea-01   #change value
  location = var.location
  address_space = var.corpAddSpace
  tags = var.tags
  depends_on = [ module.ResourceGroup ]
}

#Online Subscription

module "ResourceGroupOnline" {
  source = "./modules/ResourceGroup"
  #count= var.ResourceGroup==true ?1:0
  providers = {
    azurerm  = azurerm.DCC-Azure-Pritam
  }
  for_each = var.rg_online           # Change value 
  name=each.value
  location = var.location
  tags = var.tags
}

module "VirtualNetworkOnline" {
  source = "./modules/VirtualNetwork"
  providers = {
    azurerm = azurerm.DCC-Azure-Pritam # Change value 
  }
  vnet_name = var.onlineVNet_name
  rg_name = var.rg_online.rg-online-vnet-ea-01   #change value
  location = var.location
  address_space = var.onlineAddSpace            #change Value
  tags = var.tags
  depends_on = [ module.ResourceGroup ]
}

#Sandbox Subscription

module "ResourceGroupSanbox" {
  source = "./modules/ResourceGroup"
  #count= var.ResourceGroup==true ?1:0
  providers = {
    azurerm  = azurerm.DCC-Azure-Pritam
  }
  for_each = var.rg_sandbox            # Change value 
  name=each.value
  location = var.location
  tags = var.tags
}

module "VirtualNetworkSandbox" {
  source = "./modules/VirtualNetwork"
  providers = {
    azurerm = azurerm.DCC-Azure-Pritam # Change value 
  }
  vnet_name = var.sandboxVNet_name
  rg_name = var.rg_sandbox.rg-sandbox-ea-01  #change value
  location = var.location
  address_space = var.sandboxAddSpace            #change Value
  tags = var.tags
  depends_on = [ module.ResourceGroup ]
}

#decom Subscription

module "ResourceGroupDecom" {
  source = "./modules/ResourceGroup"
  #count= var.ResourceGroup==true ?1:0
  providers = {
    azurerm  = azurerm.DCC-Azure-Pritam
  }
  for_each = var.rg_decom          # Change value 
  name=each.value
  location = var.location
  tags = var.tags
}

module "VirtualNetworkDecom" {
  source = "./modules/VirtualNetwork"
  providers = {
    azurerm = azurerm.DCC-Azure-Pritam # Change value 
  }
  vnet_name = var.decomVNet_name
  rg_name = var.rg_decom.rg-decom-ea-01  #change value
  location = var.location
  address_space = var.decomAddSpace            #change Value
  tags = var.tags
  depends_on = [ module.ResourceGroup ]
}

# Platform to Cope and Vice Versa Virtual Network peering.

module "VNetPeering_PlatformToCorp" {
  source = "./modules/VNetPeering"
  providers = {
    azurerm=azurerm.DCCAzure-Omkar    #change Value
  }
  vnet_peername = var.VNetPeer_PlatformToCorp
  vnet_rg = var.rg_platform.rg-connectivity-mgmt-ea-01
  vnet_name = module.VirtualNetwork.VnetName
  virtual_network_ids = module.VirtualNetworkCorp.VnetId
  depends_on = [ module.VirtualNetwork, module.VirtualNetworkCorp, module.ResourceGroup ]
}

module "VNetPeering_CorpToPlatform" {
  source = "./modules/VNetPeering"
  providers = {
    azurerm = azurerm.DCC-Azure-Pritam # change Value
  }
  vnet_peername = var.VNetPeer_CoprToPlatform
  vnet_rg = var.rg_corp.rg-corp-vnet-ea-01
  vnet_name = module.VirtualNetworkCorp.VnetName
  virtual_network_ids = module.VirtualNetwork.VnetId
  depends_on = [ module.VirtualNetwork, module.VirtualNetworkCorp, module.ResourceGroup ]
}

# Platform to online and Vice Versa Virtual Network peering.
module "VNetPeering_PlatformToOnline" {
  source = "./modules/VNetPeering"
  providers = {
    azurerm=azurerm.DCCAzure-Omkar    #change Value
  }
  vnet_peername = var.VNetPeer_PlatformToOnline
  vnet_rg = var.rg_platform.rg-connectivity-mgmt-ea-01
  vnet_name = module.VirtualNetwork.VnetName
  virtual_network_ids = module.VirtualNetworkOnline.VnetId
  depends_on = [ module.VirtualNetwork, module.VirtualNetworkCorp, module.ResourceGroup ]
}

module "VNetPeering_OnlineToPlatform" {
  source = "./modules/VNetPeering"
  providers = {
    azurerm = azurerm.DCC-Azure-Pritam # change Value
  }
  vnet_peername = var.VNetPeer_OnlineToPlatform
  vnet_rg = var.rg_online.rg-online-vnet-ea-01
  vnet_name = module.VirtualNetworkOnline.VnetName
  virtual_network_ids = module.VirtualNetwork.VnetId
  depends_on = [ module.VirtualNetwork, module.VirtualNetworkCorp, module.ResourceGroup ]
}

#  Subnet 

module "subnetplatform" {
  source = "./modules/Subnet"
  providers = {
    azurerm = azurerm.DCCAzure-Omkar    # change value
  }
  subnetName = var.platformSubName
  subResourceGroup = var.rg_platform.rg-connectivity-mgmt-ea-01
  subVNet = module.VirtualNetwork.VnetName
  subAddPrefixes = var.platformSubAddPre
}

module "subnetFirewall" {
  source = "./modules/Subnet"
  providers = {
    azurerm =azurerm.DCCAzure-Omkar   # change value
  }
  subnetName = var.firewallSubnet
  subResourceGroup = var.rg_platform.rg-connectivity-mgmt-ea-01
  subVNet = module.VirtualNetwork.VnetName
  subAddPrefixes = var.firewallsubAddPre
   depends_on = [ module.ResourceGroup, module.VirtualNetwork ]
}

#Recovery Service vault

module "platformRSV" {
  source = "./modules/RecoveryServiceVault"
  providers = {
    azurerm =azurerm.DCCAzure-Omkar   # change value
  }
  recoveryvaultName = var.platformRsvName
  rsvResourcegroup = var.rg_platform.rg-identity-mgmt-ea-01
  location = var.location
  rsvSKU = var.platformRsvSku
  depends_on = [ module.ResourceGroup ]
}

#Key Vault in platform
module "platformKeyVault" {
  source = "./modules/keyVault"
  providers = {
    azurerm =azurerm.DCCAzure-Omkar   # change value
  }
  keyvaultName = var.platformKvName
  location = var.location
  keyVaultRG = var.rg_platform.rg-identity-mgmt-ea-01
  keyVaultSKU = var.platformKvSKU
  depends_on = [ module.ResourceGroup ]
}

#Monitoring
module "Monitoring" {
  source = "./modules/Monitoring"
  providers = {
    azurerm =azurerm.DCCAzure-Omkar
  }
  logAnalyticsWorkSpacwName = var.logAnalyticsWSName
  logAnalyticsWorkSpacRG= var.rg_platform.rg-platform-mgmt-ea-01
  location = var.location
  logAnalyticsSKU=var.logAnalyticsSKUMain
  logAnalyticsRetentionDays = var.logAnalyticsRetentionDaysMain

  automationAccName =var.automationAccNameMain
  automationAccRG=  var.rg_platform.rg-platform-mgmt-ea-01
  automationAccSKU =var.automationAccSKUMain

  #actionGroup
  actionGroupName = var.actionGroupNameMain
  resourceGroupName = var.rg_platform.rg-platform-mgmt-ea-01
  actionGroupShortName = var.actionGroupShortNameMain
  actionGrpEmailAddress = var.actionGrpEmailAddressMain
  actionGrpEmailReceiver = var.actionGrpEmailReceiverMain
}

#Network Security Group

module "NetworkSecurityGroupPlatform" {
  source = "./modules/NetworkSecurityGroup"
  providers = {
    azurerm =azurerm.DCCAzure-Omkar
  }
  nsgName = var.nsgNameMain
  nsgLocation = module.VirtualNetwork.vnetLocation
  nsgRG = var.rg_platform.rg-connectivity-mgmt-ea-01
}

#NSG for firewall subnet 
module "NSGFirewall" {
  source = "./modules/NetworkSecurityGroup"
  providers = {
    azurerm =azurerm.DCCAzure-Omkar
  }
  nsgName = var.nsgNameFirewall
  nsgLocation = module.VirtualNetwork.vnetLocation
  nsgRG = var.rg_platform.rg-connectivity-mgmt-ea-01
}

# #NSG Association
# module "NSGAssociation" {
#   source = "./modules/NSGAssociation"
#   providers = {
#     azurerm =azurerm.DCCAzure-Omkar     #change Value
#   }
#   subnetAssociatId = module.subnetFirewall.subnet_id
#   nsgAssociatId = module.NetworkSecurityGroupPlatform.nsgId
# }