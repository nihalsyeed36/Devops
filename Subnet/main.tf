resource "azurerm_subnet" "tf-snt" {
  for_each = var.subnet
  name           = "${var.name}-${var.env}-${each.value.purpose}-we-${each.value.num}-snt"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes       = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints
  lifecycle {
    ignore_changes = [delegation]
  }
}
