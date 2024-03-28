resource "azurerm_resource_group_template_deployment" "resource_health" {
  name                = "resource-health-deploy"
  resource_group_name = var.rg_name
  deployment_mode     = "Incremental"
 # 
  parameters_content = jsonencode({
    "actionGroupResourceId" = {
      value = azurerm_monitor_action_group.actiongroup.id
    }
    "activityLogAlertName" = {
      value = "${var.dept_id} | Azure Resource Health"
    }
  })
  template_content = <<TEMPLATE
  {
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "activityLogAlertName": {
            "type": "String",
            "metadata": {
                "description": "Unique name (within the Resource Group) for the Activity log alert."
            }
        },
        "actionGroupResourceId": {
            "type": "String",
            "metadata": {
                "description": "Resource Id for the Action group."
            }
        }

    },


    "resources": [
        {
            "type": "Microsoft.Insights/activityLogAlerts",
            "apiVersion": "2017-04-01",
            "name": "[parameters('activityLogAlertName')]",
            "location": "Global",
            "properties": {

                "enabled": true,
                "scopes": [
                    "[subscription().id]"
                ],
                "condition": {
                    "allOf": [
                        {
                            "field": "category",
                            "equals": "ResourceHealth",
                            "containsAny": null
                        },
                        {
                            "anyOf": [
                                {
                                    "field": "resourceType",
                                    "equals": "microsoft.compute/virtualmachines",
                                    "containsAny": null
                                },
                                {
                                    "field": "resourceType",
                                    "equals": "microsoft.storage/storageaccounts",
                                    "containsAny": null
                                },
                                {
                                    "field": "resourceType",
                                    "equals": "microsoft.network/applicationgateways",
                                    "containsAny": null
                                },
                                {
                                    "field": "resourceType",
                                    "equals": "microsoft.network/connections",
                                    "containsAny": null
                                },
                                {
                                    "field": "resourceType",
                                    "equals": "microsoft.network/expressroutecircuits",
                                    "containsAny": null
                                },
                                {
                                    "field": "resourceType",
                                    "equals": "microsoft.network/loadbalancers",
                                    "containsAny": null
                                },
                                {
                                    "field": "resourceType",
                                    "equals": "microsoft.network/virtualnetworkgateways",
                                    "containsAny": null
                                },
                                {
                                    "field": "resourceType",
                                    "equals": "microsoft.web/sites",
                                    "containsAny": null
                                }
                            ]
                        },
                        {
                            "anyOf": [
                                {
                                    "field": "properties.currentHealthStatus",
                                    "equals": "Available",
                                    "containsAny": null
                                },
                                {
                                    "field": "properties.currentHealthStatus",
                                    "equals": "Unavailable",
                                    "containsAny": null
                                },
                                {
                                    "field": "properties.currentHealthStatus",
                                    "equals": "Degraded",
                                    "containsAny": null
                                }
                            ]
                        },
                        {
                            "anyOf": [
                                {
                                    "field": "properties.previousHealthStatus",
                                    "equals": "Available",
                                    "containsAny": null
                                },
                                {
                                    "field": "properties.previousHealthStatus",
                                    "equals": "Unavailable",
                                    "containsAny": null
                                },
                                {
                                    "field": "properties.previousHealthStatus",
                                    "equals": "Degraded",
                                    "containsAny": null
                                }
                            ]
                        },
                        {
                            "anyOf": [
                                {
                                    "field": "properties.cause",
                                    "equals": "PlatformInitiated",
                                    "containsAny": null
                                },
                                {
                                    "field": "properties.cause",
                                    "equals": "UserInitiated",
                                    "containsAny": null
                                }
                            ]
                        },
                        {
                            "anyOf": [
                                {
                                    "field": "status",
                                    "equals": "Active",
                                    "containsAny": null
                                },
                                {
                                    "field": "status",
                                    "equals": "Resolved",
                                    "containsAny": null
                                },
                                {
                                    "field": "status",
                                    "equals": "In Progress",
                                    "containsAny": null
                                },
                                {
                                    "field": "status",
                                    "equals": "Updated",
                                    "containsAny": null
                                }
                            ]
                        }
                    ]
                },
                "actions": {
                    "actionGroups": [
                        {
                            "actionGroupId": "[parameters('actionGroupResourceId')]"
                        }
                    ]
                }
            }
        }
    ]
}


TEMPLATE

  // NOTE: whilst we show an inline template here, we recommend
  // sourcing this from a file for readability/editor support
}

