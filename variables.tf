variable "vpc" {
  type = object({
    id   = string
    name = string
    tags = optional(map(string), {})
  })

  nullable    = false
  description = "Tag VPC ID"
}

variable "subnets" {
  type = map(object({
    ids         = list(string)
    name_prefix = string
    tags        = optional(map(string), {})
  }))

  nullable    = false
  description = "Tag subnets. Key is subnet tier."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources"
}
