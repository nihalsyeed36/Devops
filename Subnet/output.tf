output "snt_id_out" {
    value = {
        for id in keys(var.subnet) : id => azurerm_subnet.tf-snt[id].id
    }
    description = "Lists the id of subnets"
}
