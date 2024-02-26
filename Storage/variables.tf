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
 #variable "resource_group_name" {
 #   type = string
 #   description = "Name of the resource group"
#}


variable "env"{
description="environment of this subcription"
}

variable "name"{
description="environment of this subcription"
}

variable "virtual_network_subnet_ids"{
description="environment of this subcription"
}


variable "tags" {
  type    = map
  default = {}
}
