resource "azurerm_management_group_policy_assignment" "monitor" {
  management_group_id = data.azurerm_management_group.mgmntgroup.id
  name                 = "Monitoring"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/55f3eceb-5573-4f18-9695-226972c6d74a"
  location = var.location
  parameters = <<VALUE
  {
    "logAnalytics_1": {
      "value": "${var.workspace_id}"
    }
  }
  VALUE
  identity { type = "SystemAssigned" }
}

resource "azurerm_management_group_policy_assignment" "benchmark" {
  management_group_id = data.azurerm_management_group.mgmntgroup.id
  name                 = "CIS Benchmark"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/c3f5c4d9-9a1d-4a99-85c0-7f93e384d5c5"
  location = var.location
  identity { type = "SystemAssigned" }
}


resource "azurerm_management_group_policy_assignment" "governance" {
  management_group_id  = data.azurerm_management_group.mgmntgroup.id
  name         = "Governance-Policy-Set"
  policy_definition_id = azurerm_policy_set_definition.governance.id
  location = var.location
  identity { type = "SystemAssigned" }
}

resource "azurerm_management_group_policy_assignment" "dataprotect" {
  management_group_id  = data.azurerm_management_group.mgmntgroup.id
  name         = "Dataprotect-Policy-Set"
  policy_definition_id = azurerm_policy_set_definition.dataprotect.id
  location = var.location
  identity { type = "SystemAssigned" }
}