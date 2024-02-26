#variable "key_vault_secret" {
#  type = map(
#    object({
#      secret_name=string
#      secret_value = string
#      })
#  )
#}

variable "inter_service_auth_username" {
}

variable "inter_service_auth_password" {
}

variable "mam_username" {
}

variable "mam_client_id" {
}

variable "mam_password" {
}

variable "postgres_username" {
}

variable "postgres_password" {
}

variable "redis_password" {
}

variable "blob_storage_connection_string" {
}

variable "azure_ad_client_id" {
}

variable "azure_ad_client_secret" {
}

variable "azure_open_ai_api_key" {
}

variable "azure_cognitive_services_api_key" {
}

variable "solution_kv_id" {
}

