

resource "azurerm_policy_set_definition" "governance" {
  name         = "${var.customerid} Governance Policy Set"
  policy_type  = "Custom"
  display_name = "${var.customerid} Governance Policy Set"


#list of allowed locations
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
    parameter_values     = <<VALUE
{
  "listOfAllowedLocations": {
    "value": ${jsonencode(var.listOfAllowedLocations)}
  }
}
    VALUE
  }

#Not allowed resource types
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6c112d4e-5bc7-47ae-a041-ea2d9dccd749"
    parameter_values     = <<VALUE
{
  "listOfResourceTypesNotAllowed": {
    "value": ${jsonencode(var.listOfResourceTypesNotAllowed)}  }

}
    VALUE
  }

  #Allowed virtual machine size SKUs
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cccc23c7-8427-4f53-ad12-b6a63eb452b3"
    parameter_values     = <<VALUE
{
  "listOfAllowedSKUs": {
    "value": ${jsonencode(var.listOfAllowedSKUs)}
  }
}
    VALUE
  }

  #resource group locations
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988"
    parameter_values     = <<VALUE
{
  "listOfAllowedLocations": {
    "value": ${jsonencode(var.listOfAllowedRGLocations)}
  }
}
    VALUE
  }
  #allowed storage type (this has been disabled but leaving the code here in case it needs to be enabled)
 /*
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cccc23c7-8427-4f53-ad12-b6a63eb452b3"
    parameter_values     = <<VALUE
{
  "listOfAllowedSKUs": {
    "value": ${jsonencode(var.listOFAllowedStoreSKU)}
  }
}
    VALUE
  }

*/
#Require a tag on resource groups Environment
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025"
    parameter_values = <<VALUE
{
  "tagName": {
    "value": ${jsonencode(var.envtagname)}
  }

}
    VALUE
  }

  #Require a tag on resource groups CostCenter

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025"
    parameter_values = <<VALUE
{
  "tagName": {
    "value": ${jsonencode(var.costcentertagname)}
  }

}
    VALUE
  }
  #appendfromRG to environment
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/9ea02ca2-71db-412d-8b00-7c7ca9fcd32d"
    parameter_values = <<VALUE
{
  "tagName": {
    "value": ${jsonencode(var.envtagname)}
  }
}
    VALUE
  }
#append tag to RG for Cost Center
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/9ea02ca2-71db-412d-8b00-7c7ca9fcd32d"
    parameter_values = <<VALUE
{
  "tagName": {
    "value": ${jsonencode(var.costcentertagname)}
  }
}
  VALUE
  }

#enable cloud defender free tier for subscription
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ac076320-ddcf-4066-b451-6154267e8ad2"
  }
}
/*

resource "azurerm_policy_set_definition" "monitoring" {
  name = "${var.customername} Monitoring Policy Set"
  policy_type = "Custom"
  display_name = "${var.customername} Monitoring Policy Set"


  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.deploy_log_analytics_agent_on_vm.id
    parameter_values     = <<VALUE
{
  "logAnalytics": {
    "value": "${var.workspaceid}"
  },

    "listOfImageIdToInclude": {
    "value": ["16.04-LTS"]
  }


}
    VALUE
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.deploy_log_analytics_agent_on_win_vm.id
    parameter_values     = <<VALUE
{
  "logAnalytics": {
    "value": "${var.workspaceid}"
  },

    "listOfImageIdToInclude": {
    "value": []
  }


}
    VALUE
  }




}
*/
