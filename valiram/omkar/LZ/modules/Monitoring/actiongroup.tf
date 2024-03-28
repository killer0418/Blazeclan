data "azurerm_client_config" "current" {}

resource "azurerm_monitor_action_group" "monitorActionGroup" {
  name = var.actionGroupName
  resource_group_name = var.resourceGroupName
  short_name = var.actionGroupShortName

  email_receiver {
    name = var.actionGrpEmailReceiver
    email_address = var.actionGrpEmailAddress
    use_common_alert_schema = true  
  }
}