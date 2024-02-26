output "rg_name_out" {
    value = {
        for name in keys(var.resource_groups) : name => azurerm_resource_group.tf-rg[name].name
    }
    description = "Lists the names of the resourcegroups"
}