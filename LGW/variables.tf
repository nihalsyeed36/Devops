variable "log_analytics_workspace" {
  type = map(
    object({
      purpose=string
      location = string
    })
  )
}
 variable "resource_group_name" {
    type = string
    description = "Name of the resource group"
}

variable "env"{
description="environment of this subcription"
}

variable "name"{
description="environment of this subcription"
}

variable "tags" {
  type    = map
  default = {}
}