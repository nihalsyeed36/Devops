resource "azurerm_resource_group" "tf-rg" {
  for_each = var.resource_groups
  name="${var.name}-${var.env}-${each.value.purpose}-we-rgp"
  location  = each.value.location
  tags = var.tags
}

#resource "azurerm_management_lock" "rg-level" {
#  for_each = {}
#  name = "cannotdelete"
#  scope = azurerm_resource_group.tf-rg[each.value].name
#  lock_level = "CanNotDelete"
#}