output "stg_account_out_id" {
    value = {
        for id in keys(var.storage_account) : id => azurerm_storage_account.tf-stg[id].id
    }
    description = "Lists the IDs of the storage account"
}