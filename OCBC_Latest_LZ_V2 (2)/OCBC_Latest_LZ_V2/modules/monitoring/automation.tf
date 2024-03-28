resource "azurerm_automation_account" "la-automation" {
  name                =  var.automationacct
  location              = var.location
  resource_group_name =  var.rg_name
  sku_name            = "Basic"
  depends_on = [azurerm_log_analytics_workspace.loganalyticsdeploy]
}

resource "azurerm_log_analytics_linked_service" "linkautomation" {
  resource_group_name = var.rg_name
  workspace_id = azurerm_log_analytics_workspace.loganalyticsdeploy.id
  read_access_id = azurerm_automation_account.la-automation.id
  depends_on = [azurerm_log_analytics_workspace.loganalyticsdeploy]
}

