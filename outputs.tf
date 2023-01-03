output "vpc" {
  value = module.vpc.vpc
}

output "vpc_id" {
  value = module.vpc.id
}

output "subnets" {
  value = { for tier, subnets in module.subnets : tier => subnets.subnets }
}

output "subnet_ids" {
  value = { for tier, subnets in module.subnets : tier => subnets.ids }
}
