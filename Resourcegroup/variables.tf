variable "resource_groups" {
  type = map(
    object({
      location = string
      purpose=string
    })
  )
}

variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "tags" {
  type    = map
  default = {}
}
