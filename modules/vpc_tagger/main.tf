data "aws_vpc" "this" {
  id = var.id
}

resource "aws_ec2_tag" "vpc" {
  for_each = merge(var.tags, {
    Name = var.name
  })

  resource_id = data.aws_vpc.this.id
  key         = each.key
  value       = each.value
}
