locals {
  subnet_tags = flatten([
    for id in var.ids : [
      for k, v in merge(var.tags, {
        Name    = "${var.name_prefix}-${var.tier}-${data.aws_subnet.this[id].availability_zone_id}"
        Tier    = var.tier
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
