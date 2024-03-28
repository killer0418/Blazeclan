resource "azurerm_policy_set_definition" "dataprotect" {
  name                = "Dataprotect Policy Set"
  management_group_id = data.azurerm_management_group.mgmntgroup.id
  policy_type         = "Custom"
  display_name        = " DataProtect Policy Set"

  # Enable Microsoft Defender for Cloud on your subscription
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ac076320-ddcf-4066-b451-6154267e8ad2"
  }
  # Inherit a tag from the resource group
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cd3aa116-8754-49c9-a813-ad46512ece54"
    parameter_values     = <<VALUE
      {
        "tagName": {
          "value": "Environment"
        }
      }
    VALUE
  }
  # Configure backup on virtual machines with a given tag to an existing recovery services vault in the same location
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/345fa903-145c-4fe1-8bcd-93ec2adccde8"
    parameter_values     = <<VALUE
      {
        "vaultLocation": {
          "value": "${var.location}"
        },
        "inclusionTagName": {
          "value":"Environment"
        },
        "inclusionTagValue": {
          "value": ["${var.tag_value}"]  
        },
        "backupPolicyId": {
          "value":"${var.backup_policy_id}"
        }
      }
    VALUE
  }
}

