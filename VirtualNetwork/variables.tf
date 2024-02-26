variable "virtual_network" {
  type = map(
    object({
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

variable "virtual_network_address_space"{
  type = list(string)
description="name of this solution"
}

variable "virtual_network_location"{
description="name of this solution"
}

variable "tags" {
  type    = map
  default = {}
}

