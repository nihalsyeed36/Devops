variable "location"{
    description = "Location of the resource group"
}
variable "resource_group_name"{
    description = "Name of the resourcegroup"
}

variable "env"{
description="environment of this subcription"
}

variable "name"{
description="environment of this subcription"
}

variable "purpose" {
  type = string
}

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

variable "subnet_agw_id" {
  description = "app gateway subnet ID"
}

variable "tags" {
  type    = map
  default = {}
}