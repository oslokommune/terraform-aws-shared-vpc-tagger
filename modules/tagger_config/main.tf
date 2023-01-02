locals {
  tags = merge(var.tags, {
    Team        = var.team
    VpcName     = var.vpc_name
    Environment = var.environment
  })
}
