provider "azurerm" {
  features {
    
  }
}
provider "azurerm" {
  features {}
  alias = "NameOfSubscription" #enter subscription name 
  subscription_id = "be510eed-cdc2-4632-9501-a44fe47aa346" #KeyIn the Subscription ID
}
provider "azurerm" {
  features {}
  alias = "NameOfSubscription1" #enter subscription name 
  subscription_id = "27adeba3-f0dc-4d7e-ae23-3ccc9a73f37d" #KeyIn the Subscription ID
}

provider "azurerm" {
  features {}
  alias = "NameOfSubscription2" #enter subscription name 
  subscription_id = "83f6da2b-dc32-44ba-9ee4-eb589b783d82" #KeyIn the Subscription ID
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.39.1"
    }
  }
}
#   backend "azurerm" {
#     resource_group_name  = "cloud-shell-storage-centralindia"
#     storage_account_name = "csg100320024687e927"
#     container_name       = "tfstate"
#     key                  = "ocbc_lz2.tfstate"
#   }
# }

