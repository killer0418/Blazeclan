data "azurerm_subscription" "current" {
}

data "azurerm_management_group" "mgmntgroup"{
  name = var.managementid
  #name = "4aede3cf-b8d9-496a-bba9-ecc94b27b7af"
}



