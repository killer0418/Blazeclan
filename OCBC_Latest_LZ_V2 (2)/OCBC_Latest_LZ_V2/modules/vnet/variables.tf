variable "vnet_name" {}
variable "rg_name" {}
variable "location" {}
variable "address_space" {}
variable "subnets_data" {
    type = list(object({
        name  = string
        address_prefixes = string
  }))
}
variable "tags" {}

