data "azurerm_client_config" "current" {}

resource "azurerm_monitor_action_group" "actiongroup" {
  name                = var.actiongroup_name
  resource_group_name = var.rg_name
  short_name          = var.actiongroup_shortname

  # itsm_receiver {
  #   name                 = "createorupdateticket"
  #   workspace_id         = "${data.azurerm_client_config.current.subscription_id}|${azurerm_log_analytics_workspace.example.workspace_id}"
  #   connection_id        = "53de6956-42b4-41ba-be3c-b154cdf17b13"
  #   ticket_configuration = "{\"PayloadRevision\":0,\"WorkItemType\":\"Incident\",\"UseTemplate\":false,\"WorkItemData\":\"{}\",\"CreateOneWIPerCI\":false}"
  #   region               = "southcentralus"
  # }

  email_receiver {
    name          = var.email_receiver_name
    email_address = var.email
    use_common_alert_schema = true
  }
  
}