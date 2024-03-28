
resource "azurerm_linux_virtual_machine" "vm_t2" {
  
  name                            = var.vm_name_t2
  resource_group_name             = var.vm_rg_name_t2
  location                        = var.location
  size                            = var.vm_size_t2
  disable_password_authentication = "false"
  admin_username                  = var.admin_username_t2
  admin_password                  = var.admin_password_t2
  network_interface_ids           = var.nic_ids_t2
  zone = var.zone_t2
  os_disk {
    caching              = var.disk_caching_t2
    storage_account_type = var.storage_account_type_t2
    disk_size_gb         = var.disk_size_gb_t2
  }
  source_image_reference {
    publisher = var.publisher_t2
    offer     = var.offer_t2
    sku       = var.sku_t2
    version   = var.vm_version_t2
  }
  plan {
    name      = var.sku_t2
    publisher = var.publisher_t2
    product   = var.offer_t2
  }
  tags = var.tags_t2
}

