variable "hub_rg_name" {
}
variable "spoke_dev_rg_name" {
  
}
variable "spoke_qa_rg_name" {
  
}
variable "spoke_prod_rg_name" {
  
}
variable "hub_location" {
}
variable "spoke_dev_location" {
  
}
variable "spoke_qa_location" {
  
}
variable "spoke_prod_location" {
  
}
variable "storage_account_policy_name" {
}
variable "hub_vnet_name" {
}
variable "spoke_dev_vnet_name" {
}
variable "spoke_qa_vnet_name" {

}
variable"spoke_qa_subnet_name"{

}
variable "spoke_prod_vnet_name" {
}
variable "spoke_prod_subnet_name" {

}
variable "spoke_dev_subnet_name" {
  
}
variable "firewall_name" {
}
variable "firewall_policy_name" {
}
variable "public_ip_name" {
}

variable "default_tags" {
  type = map
  description = "Default tags used when deploying"
}
variable "subscription_id" {
}
variable "subscription1_id" {
}
variable "route_table_dev_name" {
  
}
variable "route_table_qa_name" {
  
}
variable "route_table_prod_name" {
  
}