

data "azurerm_subscription" "current" {
}

data "azurerm_policy_set_definition" "enable_governance" {
  depends_on = [azurerm_policy_set_definition.governance]
  display_name = "${var.customerid} Governance Policy Set"
}
/*
data "azurerm_policy_set_definition" "enable_monitoring" {
  depends_on = [azurerm_policy_set_definition.monitoring]
  display_name = "${var.customername} Monitoring Policy Set"
}
*/



resource "azurerm_subscription_policy_assignment" "Governance" {
  name                 = "${var.customerid} Governance Policy Set"
  depends_on = [azurerm_policy_set_definition.governance]
  subscription_id      = "${data.azurerm_subscription.current.id}"
  policy_definition_id = "${data.azurerm_policy_set_definition.enable_governance.id}"
  location = "eastus"
  identity { type = "SystemAssigned" }


}


/*

resource "azurerm_subscription_policy_assignment" "Monitoring" {
  name                 = "${var.customername} Monitoring Policy Set"
  depends_on = [azurerm_policy_set_definition.monitoring]
  subscription_id      = "${data.azurerm_subscription.current.id}"
  policy_definition_id = "${data.azurerm_policy_set_definition.enable_monitoring.id}"
  location = "eastus"
  identity { type = "SystemAssigned" }


}

*/