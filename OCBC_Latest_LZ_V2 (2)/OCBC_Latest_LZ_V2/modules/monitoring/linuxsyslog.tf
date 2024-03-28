

resource "azurerm_resource_group_template_deployment" "linux_syslogs_log_analytics" {
  name                = "lin-perf-count-deploy"
  resource_group_name = var.rg_name
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "workspaceName" = {
      value = azurerm_log_analytics_workspace.loganalyticsdeploy.name
    }
    "location" = {
      value = var.location
    }
  })
  template_content = <<TEMPLATE
{
"$schema": "https://schema.management.azure.com/schemas/2019-08-01/deploymentTemplate.json#",
"contentVersion": "1.0.0.0",
"parameters": {
"workspaceName": {
"type": "String",
"metadata": {
"description": "Name of the workspace."
}
},
"location": {
"type": "String",
"metadata": {
"description": "Specifies the location in which to create the workspace."
}
}
},
"resources": [
{
"apiVersion": "2020-08-01",
"type": "Microsoft.OperationalInsights/workspaces",
"name": "[parameters('workspaceName')]",
"location": "[parameters('location')]",
"resources": [
{
"type": "datasources",
"apiVersion": "2020-08-01",
"name": "SyslogKern",
"dependsOn": [
"[concat('Microsoft.OperationalInsights/workspaces/', parameters('workspaceName'))]"
],
"kind": "LinuxSyslog",
"properties": {
"syslogName": "kern",
"syslogSeverities": [
{
"severity": "emerg"
},
{
"severity": "alert"
},
{
"severity": "crit"
},
{
"severity": "err"
},
{
"severity": "warning"
},
{
"severity": "notice"
},
{
"severity": "info"
},
{
"severity": "debug"
}
]
}
},
{
"type": "datasources",
"apiVersion": "2020-08-01",
"name": "SyslogDaemon",
"dependsOn": [
"[concat('Microsoft.OperationalInsights/workspaces/', parameters('workspaceName'))]"
],
"kind": "LinuxSyslog",
"properties": {
"syslogName": "daemon",
"syslogSeverities": [
{
"severity": "emerg"
},
{
"severity": "alert"
},
{
"severity": "crit"
},
{
"severity": "err"
},
{
"severity": "warning"
}
]
}
},
{
"apiVersion": "2020-08-01",
"type": "datasources",
"name": "SyslogCollection",
"dependsOn": [
"[concat('Microsoft.OperationalInsights/workspaces/', parameters('workspaceName'))]"
],
"kind": "LinuxSyslogCollection",
"properties": {
"state": "Enabled"
}
}
]
}
]
}
TEMPLATE

  // NOTE: whilst we show an inline template here, we recommend
  // sourcing this from a file for readability/editor support
}
