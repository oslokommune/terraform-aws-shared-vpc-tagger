locals {
  tags_if_shared = var.shared ? { Shared = "yes" } : {}

  tags = merge(var.tags, var.tagger_config.tags, local.tags_if_shared, {
    Tier = var.tier
  })

  subnet_name_prefix = var.shared ? var.tagger_config.vpc_name : var.tagger_config.team
  subnet_name        = "${local.subnet_name_prefix}-${var.tier}"

  subnet_tags = flatten([
    for id in var.ids : [
      for k, v in merge(local.tags, {
        Name = "${local.subnet_name}-${data.aws_subnet.this[id].availability_zone_id}"
        }) : {
        id    = id
        key   = k
        value = v
      }
    ]
  ])
}

data "aws_subnet" "this" {
  for_each = toset(var.ids)
  id       = each.value
}

resource "aws_ec2_tag" "subnet" {
  for_each = { for s in local.subnet_tags : "${s.id}-${s.key}" => s }

  resource_id = each.value.id
  key         = each.value.key
  value       = each.value.value
}
