#Secrets to be stored in KV

#resource "azurerm_key_vault_secret" "tf-password-sec" {
#    for_each=var.key_vault_secret
#    name         = each.value.secret_name
#    value        = each.value.secret_value
#    key_vault_id = var.solution_kv_id
#}

resource "azurerm_key_vault_secret" "tf-inter-service-auth-username-sec" {
  name         = "inter-service-auth-username"
  value        = var.inter_service_auth_username
  key_vault_id = var.solution_kv_id
}

resource "azurerm_key_vault_secret" "tf-inter-service-auth-password-sec" {
  name         = "inter-service-auth-password"
  value        = var.inter_service_auth_password
  key_vault_id = var.solution_kv_id
}

resource "azurerm_key_vault_secret" "tf-mam-username-sec" {
  name         = "mam-username"
  value        = var.mam_username
  key_vault_id = var.solution_kv_id
}

resource "azurerm_key_vault_secret" "tf-mam-client-id-sec" {
  name         = "mam-client-id"
  value        = var.mam_client_id
  key_vault_id = var.solution_kv_id
}

resource "azurerm_key_vault_secret" "tf-mam-password-sec" {
  name         = "mam-password"
  value        = var.mam_password
  key_vault_id = var.solution_kv_id
}

resource "azurerm_key_vault_secret" "tf-postgres-username-sec" {
  name         = "postgres-username"
  value        = var.postgres_username
  key_vault_id = var.solution_kv_id
}

resource "azurerm_key_vault_secret" "tf-postgres-password-sec" {
  name         = "postgres-password"
  value        = var.postgres_password
  key_vault_id = var.solution_kv_id
}

resource "azurerm_key_vault_secret" "tf-redis-password-sec" {
  name         = "redis-password"
  value        = var.redis_password
  key_vault_id = var.solution_kv_id
}

resource "azurerm_key_vault_secret" "tf-blob-storage-connection-string-sec" {
  name         = "blob-storage-connection-string"
  value        = var.blob_storage_connection_string
  key_vault_id = var.solution_kv_id
}

resource "azurerm_key_vault_secret" "tf-azure-ad-client-id-sec" {
  name         = "azure-ad-client-id"
  value        = var.azure_ad_client_id
  key_vault_id = var.solution_kv_id
}

resource "azurerm_key_vault_secret" "tf-azure-ad-client-secret-sec" {
  name         = "azure-ad-client-secret"
  value        = var.azure_ad_client_secret
  key_vault_id = var.solution_kv_id
}

resource "azurerm_key_vault_secret" "tf-azure-open-ai-api-key-sec" {
  name         = "azure-open-ai-api-key"
  value        = var.azure_open_ai_api_key
  key_vault_id = var.solution_kv_id
}

resource "azurerm_key_vault_secret" "tf-azure-cognitive-services-api-key-sec" {
  name         = "azure-cognitive-services-api-key"
  value        = var.azure_cognitive_services_api_key
  key_vault_id = var.solution_kv_id
}