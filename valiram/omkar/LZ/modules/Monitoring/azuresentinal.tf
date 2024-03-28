resource "azurerm_sentinel_log_analytics_workspace_onboarding" "azureSentinel" {
  workspace_id = azurerm_log_analytics_workspace.loganalytics.id
}