resource "azurerm_network_security_group" "tf-nsg" {
  for_each = var.network_security_group
  name                = "${var.name}-${var.env}-${each.value.purpose}-we-${each.value.num}-nsg"
  location            = each.value.location
  resource_group_name = var.resource_group_name
  tags = var.tags
}

# NSG association
#resource "azurerm_subnet_network_security_group_association" "tf-asso" {
#  for_each = var.network_security_group
#  subnet_id                 = each.value.subnet_id
#  network_security_group_id = azurerm_network_security_group.tf-nsg[each.key].id
#}
