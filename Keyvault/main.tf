data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "tf-kv" {
  for_each=var.key_vault
  name                        = "${var.name}-${var.env}-${each.value.purpose}-we-kv"
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = each.value.sku_name
  //soft_delete_enabled         = true
  purge_protection_enabled    = each.value.purge_protection_enabled
  enable_rbac_authorization = true
  network_acls {
    bypass = "AzureServices"
    default_action = "Deny"
    #20.41.194.0/24- ADO IP
    ip_rules                   = ["103.205.152.0/22","139.15.0.0/16","194.39.218.0/23","193.141.57.0/24","193.108.217.0/24","149.226.0.0/16","20.41.194.0/24","4.213.72.0/24", "4.213.0.215/32", "52.140.42.0/24", "4.213.0.0/24"]
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    certificate_permissions = [
      "Backup",
      "Create",
      "Delete",
      "DeleteIssuers",
      "Get",
      "GetIssuers",
      "Import",
      "List",
     "ListIssuers",
     "ManageContacts", 
      "ManageIssuers",
      "Purge",
      "Recover",
      "Restore",
      "SetIssuers",
      "Update",
    ]
    key_permissions = [
      "Backup",
      "Create",
      "Decrypt",
      "Delete",
      "Encrypt",
      "Get",
      "Import",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Sign",
      "UnwrapKey",
      "Update",
      "Verify",
      "WrapKey",
    ]
    secret_permissions = [
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set",
    ]
  }
  
  lifecycle {
    ignore_changes = [
      access_policy
    ]
  }
  tags = var.tags
}
