resource "azurerm_resource_group_template_deployment" "insights" {
  name                = "vminsights-deploy"
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
    "$schema": "https://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "workspaceName": {
          "type": "String",
          "metadata": {
          "description": "Specifies the name of the workspace."
        }
      },
      "location": {
          "type": "String",
          "defaultValue": "eastus",
          "metadata": {
            "description": "Specifies the location in which to create the workspace."
          }
      }
    },
    "resources": [
    {
      "type": "Microsoft.OperationalInsights/workspaces",
      "name": "[parameters('workspaceName')]",
      "apiVersion": "2015-11-01-preview",
      "location": "[parameters('location')]",
      "properties": {
        "features": {
          "searchVersion": 2
        }
      }
    },
    {
      "type": "Microsoft.OperationsManagement/solutions",
      "apiVersion": "2015-11-01-preview",
      "name": "[concat('AzureActivity(', parameters('workspaceName'),')')]",
      "location": "[parameters('location')]",
      "dependsOn": [
        "[resourceId('microsoft.operationalinsights/workspaces', parameters('workspaceName'))]"
      ],
      "plan": {
        "name": "[concat('AzureActivity(', parameters('workspaceName'),')')]",
        "promotionCode": "",
        "product": "OMSGallery/AzureActivity",
        "publisher": "Microsoft"
      },
      "properties": {
        "workspaceResourceId": "[resourceId('microsoft.operationalinsights/workspaces', parameters('workspaceName'))]",
        "containedResources": [
          "[concat(resourceId('microsoft.operationalinsights/workspaces', parameters('workspaceName')), '/views/AzureActivity(',parameters('workspaceName'))]"
        ]
      }
    },
    {
      "type": "Microsoft.OperationalInsights/workspaces/datasources",
      "kind": "AzureActivityLog",
      "name": "[concat(parameters('workspaceName'), '/', subscription().subscriptionId)]",
      "apiVersion": "2015-11-01-preview",
      "location": "[parameters('location')]",
      "dependsOn": [
          "[parameters('WorkspaceName')]"
      ],
      "properties": {
          "linkedResourceId": "[concat(subscription().Id, '/providers/microsoft.insights/eventTypes/management')]"
      }
    }]
  }
  TEMPLATE
  // NOTE: whilst we show an inline template here, we recommend
  // sourcing this from a file for readability/editor support
  
}

