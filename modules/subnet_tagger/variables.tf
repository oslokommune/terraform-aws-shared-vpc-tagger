variable "ids" {
  type        = list(string)
  nullable    = false
  description = "IDs of shared subnets for this tier"
}

variable "name_prefix" {
  type        = string
  nullable    = false
  description = "First part of the subnet name. Will be concatenated with tier and availability zone id."
}

variable "tier" {
  type        = string
  nullable    = false
  description = "Subnet tier (private/public/database/etc...)"
}

variable "tags" {
  type     = map(string)
  default  = {}
  nullable = false
}
