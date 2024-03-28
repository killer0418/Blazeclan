
variable "location" {}

variable "vnet_name_t2" {}
variable "rg_name_t2" {}
variable "address_space_t2" {}
variable "subnets_data_t2" {
    type = list(object({
        name  = string
        address_prefixes = string
  }))
}
variable "tags_t2" {}
