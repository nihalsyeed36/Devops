resource "azurerm_storage_account"  "tf-stg" {
  for_each = var.storage_account
    name                      = "${var.name}${var.env}${each.value.purpose}westg"
  resource_group_name       = each.value.resource_group_name
  location                  = each.value.location
  account_kind              = each.value.account_kind
  account_tier              = each.value.account_tier
  account_replication_type  = each.value.account_replication_type
  min_tls_version           = each.value.min_tls_version
  enable_https_traffic_only = each.value.enable_https_traffic_only
  public_network_access_enabled = true
  network_rules {
    default_action = "Deny"
    ip_rules                   = ["103.205.152.0/22","139.15.0.0/16","194.39.218.0/23","193.141.57.0/24","193.108.217.0/24","149.226.0.0/16"]
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
    private_link_access {
      endpoint_resource_id = "/subscriptions/190bc9e2-3b22-47f2-9bc6-33de890fdcc3/providers/Microsoft.Security/datascanners/StorageDataScanner"
      endpoint_tenant_id   = "0ae51e19-07c8-4e4b-bb6d-648ee58410f4"
    }
  }
  tags = var.tags
}
