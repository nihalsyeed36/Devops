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

variable "location" {
  type        = string
  description = "Resources location in Azure"
}

variable "purpose" {
  type = string
}

variable "oai_sku" {
  type = string
}


variable "oai_custom_subdomain_name" {
  type = string
}

#variable "subnet_id" {
#  type = string
#}

variable "nw_resource_group_name" {
  type = string
}

variable "app_subnet_id" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "tags" {
  type    = map
  default = {}
}