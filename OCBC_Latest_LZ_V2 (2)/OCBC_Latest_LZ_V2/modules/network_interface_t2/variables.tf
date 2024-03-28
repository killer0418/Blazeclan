variable "location" {}
variable "nic_rg_name" {}
variable "delete_time-nic" {}
variable "nic_properties" {
  type = list(object({
      name  = string
      ip_config_name = string
      private_ip_address_allocation  = string
      private_ip_address   = string
  }))
}
variable "nsg_name" {}
variable "subnet_ids" {}
variable "tags" {}

