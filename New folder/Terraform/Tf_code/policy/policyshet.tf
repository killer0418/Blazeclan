provider "azurerm" {
 features {}
}

resource "azurerm_policy_definition" "diagnostic_settings" {
 name         = "require-diagnostic-settings"
 display_name = "Require Diagnostic Settings"
 description  = "Enforce diagnostic settings on resources"

 policy_type = "Custom"
 mode        = "All"

 metadata = <<-METADATA
   {
     "category": "Monitoring"
   }
 METADATA

 policy_rule = <<POLICY_RULE
   {
     "if": {
       "field": "type",
       "equals": "Microsoft.Storage/storageAccounts"
     },
     "then": {
       "effect": "deployIfNotExists",
       "details": {
         "type": "Microsoft.Insights/diagnosticSettings",
         "existenceCondition": {
           "allOf": [
             {
               "field": "Microsoft.Insights/diagnosticSettings/logs[?name=='default']",
               "equals": "exists('true')"
             },
             {
               "field": "Microsoft.Insights/diagnosticSettings/metrics[?name=='default']",
               "equals": "exists('true')"
             }
           ]
         },
      
         "deploymentMode": "incremental",
         "deploymentName": "diagnostic-settings-deployment",
         "policy": {
           "status": "enabled",
           "definitionReferenceId": "{azurerm_policy_definition.diagnostic_settings.id}"
         }
       }
     }
   }
 POLICY_RULE
}

# resource "azurerm_policy_assignment" "diagnostic_settings" {
#  name                 = "require-diagnostic-settings-assignment"
#  policy_definition_id = azurerm_policy_definition.diagnostic_settings.id
#  scope                = "/subscriptions/7ca44967-319a-4e6c-b46f-298dcf9a15c6"

# }