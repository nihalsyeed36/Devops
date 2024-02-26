#RG
variable "resource_groups" {
  type = map(
    object({
      location = string
      purpose=string
    })
  )
}

variable "env" {
  type = string
}

variable "name" {
  type = string
}

# Keyvault
variable "key_vault" {
  type = map(
    object({
      location = string
      purpose=string
      sku_name=string
      purge_protection_enabled=string
      resource_group_name = string
    })
  )
}

#Keyvault secrets
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


#Storage account
variable "storage_account" {
  type = map(
    object({
      purpose=string
      location = string
      account_kind              = string
      account_tier              = string 
      account_replication_type  = string
      min_tls_version           = string
      enable_https_traffic_only = string
      resource_group_name = string
    })
  )
}

#VNET
variable "virtual_network" {
  type = map(
    object({
      })
  )
}

variable "virtual_network_address_space"{
  type = list(string)
description="name of this solution"
}

variable "virtual_network_location"{
description="name of this solution"
}

variable "subnet" {
  type = map(
    object({
      purpose = string
      location = string
      num = string
      address_prefixes  = list(string)
      service_endpoints = list(string)
      })
  )
}

variable "network_security_group" {
  type = map(
    object({
      purpose=string
      location = string
      num = string
      })
  )
}


#AKS
variable "aks" {
  type = map(
    object({
      })
  )
}

variable "location" {
  type        = string
  description = "Resources location in Azure"
}
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}

variable "purpose" {
  type = string
}


variable "aks_dns_service_ip" {
  type = string
}


variable "aks_service_cidr" {
  type = string
}

variable "aks_resource_group_name" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
  sensitive = true
}

variable "aks_spn_objectid" {
  type = string
}

variable "aks_identity_name" {
  type = string
}



#variable "namespace_name" {
#  type = string
#}


#Postgresql
variable "postgresql" {
  type = map(
    object({
        purpose=string
        num=number
        location = string
        administrator_login          = string
        administrator_password = string

        sku_name   = string
        storage_mb = number
        version    = string

        backup_retention_days         = number
        geo_redundant_backup_enabled  = string
  })
  )
}

#App gateway variables
variable "appgw_sku_name"{
    description = "Application Gateway SKU Name"
}
variable "appgw_sku_tier"{
    description = "Application Gateway SKU Tier"
}
variable "appgw_capacity"{
    description = "Application Gateway Capacity"
    type=number
}

#Redis cache 
variable "redis_sku_name" {
  type = string
}

variable "family" {
  type = string
}

#LGW
variable "log_analytics_workspace" {
  type = map(
    object({
      purpose=string
      location = string
    })
  )
}

#CGS
variable "cgs_sku" {
  type = string
}

variable "custom_subdomain_name" {
  type = string
}


#OAI
variable "oai_sku" {
  type = string
}

variable "oai_custom_subdomain_name" {
  type = string
}


#Tags
variable "tags" {
  type    = map
  default = {}
}