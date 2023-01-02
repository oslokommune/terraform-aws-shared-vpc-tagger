variable "vpc_name" {
  type        = string
  nullable    = false
  description = "Name of VPC"
}

variable "team" {
  type        = string
  nullable    = false
  description = "Name of the team"
}

variable "environment" {
  type        = string
  nullable    = false
  description = "Name of the environment (dev/prod)"
}

variable "tags" {
  type     = map(string)
  default  = {}
  nullable = false
}
