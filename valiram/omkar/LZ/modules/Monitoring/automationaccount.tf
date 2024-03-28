resource "azurerm_automation_account" "automationAcc" {
  name = var.automationAccName
  location = var.location
  resource_group_name = var.automationAccRG
  sku_name = var.automationAccSKU
  depends_on = [ azurerm_log_analytics_workspace.loganalytics ]
}