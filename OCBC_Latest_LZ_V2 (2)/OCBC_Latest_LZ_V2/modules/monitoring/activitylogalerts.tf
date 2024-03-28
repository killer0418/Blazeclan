resource "azurerm_monitor_activity_log_alert" "stoppedresource" {
  name                = "${var.dept_id} | A Resource has been stopped"
  resource_group_name =  var.rg_name
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}"]
  description         = "This alert will monitor if any virtual machines are stopped."

  criteria {
    operation_name = "Microsoft.Compute/virtualMachines/powerOff/action"
    category       = "Administrative"
    resource_type  = "microsoft.compute/virtualmachines"
    status         = "Failed, Succeeded"

  }

  action {
    action_group_id = azurerm_monitor_action_group.actiongroup.id
  }
  
}

resource "azurerm_monitor_activity_log_alert" "changedupdatedvirtual" {
  name                = "${var.dept_id} | A resource has been created or updated"
  resource_group_name =  var.rg_name
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}"]
  description         = "This alert will monitor if any virtual machine resource has been changed or updated."

  criteria {
    operation_name = "Microsoft.Compute/virtualMachines/write"
    category       = "Administrative"
    resource_type  = "microsoft.compute/virtualmachines"
    status         = "Failed, Succeeded"

  }

  action {
    action_group_id = azurerm_monitor_action_group.actiongroup.id
  }
  
}


resource "azurerm_monitor_activity_log_alert" "deallocated" {
  name                = "${var.dept_id} | A resource has been De-allocated"
  resource_group_name = var.rg_name
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}"]
  description         = "This alert will monitor if any virtual machine has been deallocated."

  criteria {
    operation_name = "Microsoft.Compute/virtualMachines/deallocate/action"
    category       = "Administrative"
    resource_type  = "microsoft.compute/virtualmachines"
    status         = "Failed, Succeeded"
  }

  action {
    action_group_id = azurerm_monitor_action_group.actiongroup.id
  }
  
}

resource "azurerm_monitor_activity_log_alert" "roledelete" {
  name                = "${var.dept_id} | A role has been Deleted"
  resource_group_name = var.rg_name
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}"]
  description         = "This alert will monitor if any role has been deleted."

  criteria {
    operation_name = "Microsoft.Authorization/roleAssignments/delete"
    category       = "Administrative"
    resource_type  = "microsoft.compute/virtualmachines"
    status         = "Failed, Succeeded"
  }

  action {
    action_group_id = azurerm_monitor_action_group.actiongroup.id
  }
  
}

resource "azurerm_monitor_activity_log_alert" "machinestart" {
  name                = "${var.dept_id} | A Virtual Machine has been started"
  resource_group_name = var.rg_name
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}"]
  description         = "This alert will monitor if any stopped virtual Machines have been started."

  criteria {
    operation_name = "Microsoft.Compute/virtualMachines/start/action"
    category       = "Administrative"
    resource_type  = "microsoft.compute/virtualmachines"
    status         = "Failed, Succeeded"
  }

  action {
    action_group_id = azurerm_monitor_action_group.actiongroup.id
  }
  
}


