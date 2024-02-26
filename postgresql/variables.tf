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

variable "env"{
description="environment of this subcription"
}

variable "name"{
description="name of this solution"
}

variable "resource_group_name" {
    type = string
    description = "Name of the resource group"
}

variable "nw_resource_group_name" {
    type = string
    description = "Name of the network resource group"
}

variable "virtual_network_id" {
    type = string
    description = "id of the VNET"
}

variable "subnet_db_id" {
    type = string
    description = "id of the DB subnet"
}

variable "tags" {
  type    = map
  default = {}
}