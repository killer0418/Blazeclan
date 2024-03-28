resource "azurerm_bastion_host" "main" {
  name                   = lower(var.azure_bastion_service_name)
  location               = azurerm_resource_group.rg.location
  resource_group_name    = azurerm_resource_group.rg.name
  copy_paste_enabled     = var.enable_copy_paste
  file_copy_enabled      = var.bastion_host_sku == "Standard" ? var.enable_file_copy : null
  sku                    = var.bastion_host_sku
  ip_connect_enabled     = var.enable_ip_connect
  scale_units            = var.bastion_host_sku == "Standard" ? var.scale_units : 2
  shareable_link_enabled = var.bastion_host_sku == "Standard" ? var.enable_shareable_link : null
  tunneling_enabled      = var.bastion_host_sku == "Standard" ? var.enable_tunneling : null
  depends_on = [
    azurerm_resource_group.rg
  ]
  ip_configuration {
    name                 = "${lower(var.azure_bastion_service_name)}-network"
    subnet_id            = azurerm_subnet.abs_snet.id
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}
