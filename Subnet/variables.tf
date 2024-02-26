variable "subnet" {
  type = map(
    object({
      purpose=string
      location = string
      num = string
      address_prefixes  = list(string)
      service_endpoints = list(string)
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
  type        = string
  description = "Name of the parent resource group"
}

variable "virtual_network_name" {
  type        = string
  description = "Name of the VNET"
}



