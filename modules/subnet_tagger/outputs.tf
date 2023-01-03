output "ids" {
  value = var.ids
}

output "subnets" {
  value = { for s in data.aws_subnet.this : s.availability_zone_id => s }
}
