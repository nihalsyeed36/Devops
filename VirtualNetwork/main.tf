resource "azurerm_virtual_network" "tf-vnet" {
  name                = "${var.name}-${var.env}-network-we-vnet"
  location            = var.virtual_network_location
  resource_group_name = var.resource_group_name
  address_space       = var.virtual_network_address_space
  tags = var.tags
}