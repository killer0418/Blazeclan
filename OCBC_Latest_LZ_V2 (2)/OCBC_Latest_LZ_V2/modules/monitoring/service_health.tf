resource "azurerm_resource_group_template_deployment" "service_health" {
  name                = "service-health-deploy"
  resource_group_name = var.rg_name
  deployment_mode     = "Incremental"
  
  parameters_content = jsonencode({
    "actionGroupResourceId" = {
      value = azurerm_monitor_action_group.actiongroup.id
    }
    "activityLogAlertName" = {
      value = "${var.dept_id} | Azure Service Health"
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
    "activityLogAlertEnabled": {
      "type": "Bool",
      "defaultValue": true,
      "metadata": {
        "description": "Indicates whether or not the alert is enabled."
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
      "tags": {},
      "properties": {
        "enabled": "[parameters('activityLogAlertEnabled')]",
        "description": "",
        "scopes": [
          "[subscription().id]"
        ],
        "condition": {
          "allOf": [
            {
              "field": "category",
              "equals": "ServiceHealth"
            }
          ]
        },
        "actions": {
          "actionGroups":
          [
            {
              "actionGroupId": "[parameters('actionGroupResourceId')]",
              "webhookProperties": {}
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

