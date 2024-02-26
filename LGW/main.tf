resource "azurerm_log_analytics_workspace" "tf-lgw" {
    for_each = var.log_analytics_workspace
        name                      = "${var.name}-${var.env}-${each.value.purpose}-we-lgw"
    resource_group_name       = var.resource_group_name
    location                  = each.value.location
    sku                 = "PerGB2018"
    retention_in_days   = 30
    tags = var.tags
}