variable "key_vault" {
  type = map(
    object({
      purpose=string
      location = string
      sku_name=string
      purge_protection_enabled=string
      resource_group_name = string
      })
  )
}

variable "env"{
description="environment of this subcription"
}

variable "name"{
description="environment of this subcription"
}

variable "virtual_network_subnet_ids" {
}

variable "tags" {
  type    = map
  default = {}
}
