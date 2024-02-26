variable "network_security_group" {
  type = map(
    object({
      purpose = string
      num = string
      location = string
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

variable "tags" {
  type    = map
  default = {}
}

