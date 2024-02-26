output "nsg_id_out" {
    value = {
        for id in keys(var.network_security_group) : id => azurerm_network_security_group.tf-nsg[id].id
    }
    description = "Lists the id of subnets"
}
