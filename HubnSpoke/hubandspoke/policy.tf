resource "azurerm_resource_group_policy_assignment" "pol1" {
  provider            = azurerm.hub
  name                 = var.storage_account_policy_name
  display_name         = "Storage accounts should be limited by allowed SKUs"
  location             = var.hub_location
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7433c107-6db4-4ad1-b57a-a76dce0154a1"
  resource_group_id    = azurerm_resource_group.hub_rg.id
  enforce              = true
  identity {
    type = "SystemAssigned"
  }
  non_compliance_message {
    content = "Please select Redundancy as LRS"
  }
  parameters = <<PARAMETERS
    {
    "listOfAllowedSKUs": {
      "value":["premium_lrs","standard_lrs"]
    }
  }
PARAMETERS
}

