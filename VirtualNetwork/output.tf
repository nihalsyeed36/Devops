output "vnet_name_out" {
  value = "${azurerm_virtual_network.tf-vnet.name}"
}

output "vnet_id_out" {
  value = "${azurerm_virtual_network.tf-vnet.id}"
}