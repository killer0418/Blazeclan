resource "azurerm_backup_policy_vm" "default_backup_policy" {
  name                = var.backuppolicyname
  resource_group_name = var.rg_name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  timezone = "UTC"
  backup {
    frequency = "Daily"
    time      = "23:00"
  }
  retention_daily {
    count = 10
  }
  retention_weekly {
    count    = 42
    weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
  }
  retention_monthly {
    count    = 7
    weekdays = ["Sunday", "Wednesday"]
    weeks    = ["First", "Last"]
  }
  retention_yearly {
    count    = 77
    weekdays = ["Sunday"]
    weeks    = ["Last"]
    months   = ["January"]
  }
  depends_on = [azurerm_backup_policy_vm.default_backup_policy]
}