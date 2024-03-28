resource "azurerm_log_analytics_workspace" "loganalytics" {
  name =var.logAnalyticsWorkSpacwName
  location = var.location
  resource_group_name = var.logAnalyticsWorkSpacRG
  sku = var.logAnalyticsSKU
  retention_in_days = var.logAnalyticsRetentionDays
}