# resource "azurerm_management_group_policy_remediation" "dataprotect" {
#   name                 = "dataprotect"
#   management_group_id  = data.azurerm_management_group.mgmntgroup.id
#   policy_assignment_id = azurerm_management_group_policy_assignment.dataprotect.id
#   location_filters     = var.listOfAllowedLocations
# }
