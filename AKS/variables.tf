variable "aks" {
  type = map(
    object({
      })
  )
}

variable "env"{
description="environment of this subcription"
}

variable "name"{
description="environment of this subcription"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the parent resource group"
}

variable "aks_resource_group_name" {
  type        = string
  description = "Name of the parent resource group"
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

variable "subnet_aks_id" {
  description = "aks subnet ID"
}

variable "aks_dns_service_ip" {
  type = string
}


variable "aks_service_cidr" {
  type = string
}

variable "app_gw_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
  sensitive = true
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "acr_id" {
  type = string
}

variable "solution_stg_id" {
  type = string
}

variable "aks_identity_name" {
  type = string
}

variable "keyvault_id" {
  type = string
}

variable "aks_spn_objectid" {
  type = string
}

#variable "namespace_name" {
#  type = string
#}

variable "tags" {
  type    = map
  default = {}
}