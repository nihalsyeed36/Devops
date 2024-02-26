output "log_analytics_out" {
    value = {
        for name in keys(var.log_analytics_workspace) : name => azurerm_log_analytics_workspace.tf-lgw[name].name
    }
    description = "Lists the names of the Log Analytics Workspace"
}

output "log_analytics_out_id" {
    value = {
        for id in keys(var.log_analytics_workspace) : id => azurerm_log_analytics_workspace.tf-lgw[id].id
    }
    description = "Lists the names of the Log Analytics Workspace"
}