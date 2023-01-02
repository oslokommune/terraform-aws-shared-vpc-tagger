output "ids" {
  value = var.ids
}

output "subnets" {
  value = data.aws_subnet.this
}
