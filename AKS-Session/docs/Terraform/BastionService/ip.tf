resource "azurerm_public_ip" "pip" {
  name                = lower("${var.azure_bastion_service_name}-${var.location}-pip")
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  domain_name_label   = var.domain_name_label != null ? var.domain_name_label : format("gw%s%s", lower(replace(var.azure_bastion_service_name, "/[[:^alnum:]]/", "")), random_string.str.result)
  depends_on = [
    azurerm_resource_group.rg
  ]
  lifecycle {
    ignore_changes = [
      tags,
      ip_tags,
    ]
  }
}
