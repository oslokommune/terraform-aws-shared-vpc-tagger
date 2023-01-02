variable "id" {
  type        = string
  nullable    = false
  description = "ID of shared VPC"
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
