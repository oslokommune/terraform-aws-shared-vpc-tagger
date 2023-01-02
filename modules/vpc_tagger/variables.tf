variable "id" {
  type        = string
  nullable    = false
  description = "ID of shared VPC"
}

variable "name" {
  type        = string
  nullable    = false
  description = "Name of shared VPC"
}

variable "tags" {
  type     = map(string)
  default  = {}
  nullable = false
}
