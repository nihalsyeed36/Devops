output "key_vault_out_id" {
    value = {
        for id in keys(var.key_vault) : id => azurerm_key_vault.tf-kv[id].id
    }
    description = "Lists the IDs of the Keyvault"
}