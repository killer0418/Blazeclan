resource "azurerm_subnet_network_security_group_association" "nsgAssociation" {
  subnet_id = var.subnetAssociatId 
  network_security_group_id = var.nsgAssociatId 
}