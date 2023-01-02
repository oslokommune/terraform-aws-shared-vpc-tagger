locals {
  tags = merge(var.tagger_config.tags, var.tags, {
    Name = var.tagger_config.vpc_name
  })
}

data "aws_vpc" "this" {
  id = var.id
}

resource "aws_ec2_tag" "vpc" {
  for_each = local.tags

  resource_id = data.aws_vpc.this.id
  key         = each.key
  value       = each.value
}
