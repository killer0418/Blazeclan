provider "azurerm" {
  features {}  
  alias           = "hub"
  subscription_id = var.subscription_id
}
provider "azurerm" {
  features {}  
  alias           = "dev"
  subscription_id = var.subscription1_id
}

