####Performance Countes for Windows##################
resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcpu" {
  name                = "cpu-lad-wpc"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "CPU"
  instance_name       = "*"
  counter_name        = "CPU"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcmem" {
  name                = "memory-lad-wpc"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "Memory"
  instance_name       = "*"
  counter_name        = "Available MBytes"
  interval_seconds    = 40
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcdiskread" {
  name                = "diskread-lad-wpc"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Avg. Disk sec/Read"
  interval_seconds    = 40
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcdiskwrite" {
  name                = "diskwrite-lad-wpc"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Avg. Disk sec/Write"
  interval_seconds    = 40
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcdiskqueue" {
  name                = "diskqueue-lad-wpc"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Current Disk Queue Length"
  interval_seconds    = 40
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcdiskreadpersec" {
  name                = "diskreadpersec-lad-wpc"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Disk Reads/sec"
  interval_seconds    = 40
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcdiskxferpersec" {
  name                = "disk-xfer-persec-lad-wpc"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Disk Transfers/sec"
  interval_seconds    = 40
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpdiskwritepersec" {
  name                = "diskwrite-persec-lad-wpc"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Disk Writes/sec"
  interval_seconds    = 40
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcdiskfreemb" {
  name                = "freemb-lad-wpc"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Free Megabytes"
  interval_seconds    = 40
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcdiskavailablemb" {
  name                = "available-mb-lad-wpc"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Available MBytes"
  interval_seconds    = 40
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcpercentfree" {
  name                = "percent-free-lad-wpc"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "% Free Space"
  interval_seconds    = 40
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcmemcommittedinuse" {
  name                = "memory-inuse-lad-wpc"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "Memory"
  instance_name       = "*"
  counter_name        = "% Committed Bytes In Use"
  interval_seconds    = 40
}


resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcnetbytesrecieved" {
  name                = "network-bytes-in-persec"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "Network Adapter"
  instance_name       = "*"
  counter_name        = "Bytes Received/sec"
  interval_seconds    = 40
}



resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcnetbytesent" {
  name                = "network-bytes-sent-per-second"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "Network Adapter"
  instance_name       = "*"
  counter_name        = "Bytes Sent/sec"
  interval_seconds    = 40
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcnetinterface" {
  name                = "network-interface-bytes-total"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "Network Interface"
  instance_name       = "*"
  counter_name        = "Bytes Total/sec"
  interval_seconds    = 40
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcprocessortime" {
  name                = "percent-procesor-time"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "Processor"
  instance_name       = "(_Total)"
  counter_name        = "% Processor Time"
  interval_seconds    = 40
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "wpcprocessorqueuelength" {
  name                = "network-bytes-sent-persec"
  resource_group_name =  var.rg_name
  workspace_name      = azurerm_log_analytics_workspace.loganalyticsdeploy.name
  object_name         = "System"
  instance_name       = "*"
  counter_name        = "Processor Queue Length"
  interval_seconds    = 40
}
