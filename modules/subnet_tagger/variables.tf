variable "ids" {
  type        = list(string)
  nullable    = false
  description = "IDs of shared subnets for this tier"
}

variable "tier" {
  type        = string
  nullable    = false
  description = "Subnet tier (private/public/database/etc...)"
}

variable "shared" {
  type    = bool
  default = false
}

variable "tagger_config" {
  type = object({
    vpc_name = string
    team     = string
    tags     = map(string)
  })
  nullable = false
}

variable "tags" {
  type     = map(string)
  default  = {}
  nullable = false
}
