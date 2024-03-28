resource "azurerm_log_analytics_datasource_windows_event" "adweb" {
  name                = "Active-Directory-Web-error"
  resource_group_name = var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  event_log_name      = "Active Directory Web Services"
    event_types         = ["Error", "Warning"]
}

resource "azurerm_log_analytics_datasource_windows_event" "analytic" {
  name                = "Analytic"
  resource_group_name = var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  event_log_name      = "Analytic"
  event_types         = ["Error", "Warning"]
}

resource "azurerm_log_analytics_datasource_windows_event" "directory_service" {
  name                = "Directory-Service"
  resource_group_name = var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  event_log_name      = "Directory Services"
  event_types         = ["Error", "Warning"]
}

resource "azurerm_log_analytics_datasource_windows_event" "netlogon" {
  name                = "Netlogon-Operational"
  resource_group_name = var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  event_log_name      = "Microsoft-Windows-Security-Netlogon/Operational"
  event_types         = ["Error", "Warning"]
}

resource "azurerm_log_analytics_datasource_windows_event" "wmi-activity" {
  name                = "WMI-Activity-Operational"
  resource_group_name = var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  event_log_name      = "Microsoft-Windows-WMI-Activity/Operational"
  event_types         = ["Error", "Warning"]
}

resource "azurerm_log_analytics_datasource_windows_event" "system" {
  name                = "System-Error"
  resource_group_name = var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  event_log_name      = "System"
  event_types         = ["Error", "Warning"]
}

##DIAGNOSTIC settings ####
resource "azurerm_monitor_diagnostic_setting" "azmondiagnostic" {
  name               = "loganalyticsdiagsettings"
  target_resource_id = azurerm_log_analytics_workspace.loganalyticsdeploy.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.loganalyticsdeploy.id

  log {
    category = "Audit"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }
}
