module "vpc" {
  source = "./modules/vpc_tagger"
  id     = var.vpc.id
  name   = var.vpc.name
  tags   = merge(var.tags, var.vpc.tags)
}

module "subnets" {
  source = "./modules/subnet_tagger"

  for_each = var.subnets

  ids = each.value.ids
  name_prefix = each.value.name_prefix
  tier = each.key
  tags = merge(var.tags, each.value.tags)
}
