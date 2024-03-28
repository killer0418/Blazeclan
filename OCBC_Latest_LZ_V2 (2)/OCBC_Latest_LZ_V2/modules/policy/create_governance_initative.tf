resource "azurerm_policy_set_definition" "governance" {
  name         = "Governance Policy Set"
  management_group_id = data.azurerm_management_group.mgmntgroup.id
  policy_type  = "Custom"
  display_name = "Governance Policy Set"

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
  #Storage accounts should be limited by allowed SKUs
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7433c107-6db4-4ad1-b57a-a76dce0154a1"
    parameter_values     = <<VALUE
    {
      "listOfAllowedSKUs": {
        "value": ${jsonencode(var.listOFAllowedStoreSKU)}
      }
    }
    VALUE
  }

  #appendfromRG
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/49c88fc8-6fd1-46fd-a676-f12d1d3a4c71"
    parameter_values = <<VALUE
    {
      "tagName": {
        "value": ${jsonencode(var.costcentertagname)}
      },
      "tagValue": {
        "value": ${jsonencode(var.costcentertagvalue)}
      }
    }
    VALUE
  }

  #Enable Network Watcher
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b6e2945c-0b7b-40f5-9233-7a5323b5cdc6"
  }

  #App Service apps should only be accessible over HTTPS
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a4af4a39-4135-47fb-b175-47fbdf85311d"
  }

  #App Service apps should use a SKU that supports private link
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/546fe8d2-368d-4029-a418-6af48a7f61e5"
  }

  #Function apps should only be accessible over HTTPS
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6d555dd1-86f2-4f1c-8ed7-5abae7c6cbab"
  }

  #Key vaults should have soft delete enabled
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d"
  }

  #Subnets should have a Network Security Group
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e71308d3-144b-4262-b144-efdc3cc90517"
  }

  #Kubernetes clusters should not allow container privilege escalation
  # policy_definition_reference {
  #   policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1c6e92c9-99f0-4e55-9cf2-0c234dc48f99"
  # }

  #Kubernetes clusters should be accessible only over HTTPS
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d"
  }

  # Kubernetes cluster should not allow privileged containers
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/95edb821-ddaf-4404-9732-666045e056b4"
  }

  #Secure transfer to storage accounts should be enabled
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9"
  }

  #Audit VMs that do not use managed disks
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d"
  }

  #Azure Backup should be enabled for Virtual Machines
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/013e242c-8828-4970-87b3-ab247555486d"
  }

  #Auditing on SQL server should be enabled 
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a6fb4358-5bf4-4ad7-ba82-2cd2f41ce5e9"
  }

  #Audit virtual machines without disaster recovery configured
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0015ea4d-51ff-4ce3-8d8c-f3f8f0179a56"
  }

  #Configure Windows virtual machine scale sets to run Azure Monitor Agent using system-assigned managed identity
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4efbd9d8-6bc6-45f6-9be2-7fe9dd5d89ff"
  }

  #Network interfaces should not have public IPs
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/83a86a26-fd1f-447c-b59d-e51f44264114"
  }

  #Key Rotation Policy
  # policy_definition_reference {
  #   policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/83a86a26-fd1f-447c-b59d-e51f44264114"
  # }

  #Flow logs should be configured and enabled for every network security group
  # policy_definition_reference {
  #   policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/62329546-775b-4a3d-a4cb-eb4bb990d2c0"
  # }

  #OS and data disks should be encrypted with a customer-managed key
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/702dd420-7fcc-42c5-afe8-4026edd20fe0"
  }

  #SQL servers should use customer-managed keys to encrypt data at rest
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0a370ff3-6cab-4e85-8995-295fd854c5b8"
  }

  #SQL managed instances should use customer-managed keys to encrypt data at rest`
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ac01ad65-10e5-46df-bdd9-6b0cad13e1d2"
  }

  #MySQL servers should use customer-managed keys to encrypt data at rest
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/83cef61d-dbd1-4b20-a4fc-5fbc7da10833"
  }
  #Container registries should be encrypted with a customer-managed key
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/5b9159ae-1701-4a6f-9a7a-aa9c8ddd0580"
  }
  #PostgreSQL servers should use customer-managed keys to encrypt data at rest
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/18adea5e-f416-4d0f-8aa8-d24321e3e274"
  }

  #Azure Cosmos DB accounts should use customer-managed keys to encrypt data at rest
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f905d99-2ab7-462c-a6b0-f709acca6c8f"
  }
}



