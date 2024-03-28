

resource "azurerm_linux_virtual_machine" "vm" {
 
  name                            = var.vm_name
  resource_group_name             = var.vm_rg_name
  location                        = var.location
  size                            = var.vm_size
  disable_password_authentication = "false"
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  network_interface_ids           = var.nic_ids
  zone = var.zone
  os_disk {
    caching              = var.disk_caching
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size_gb
  }
  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.vm_version
  }
  plan {
    name      = var.sku
    publisher = var.publisher
    product   = var.offer
  }
  tags = var.tags
}



