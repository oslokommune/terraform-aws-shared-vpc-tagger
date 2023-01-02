output "id" {
  value = var.id
}

output "vpc" {
  value = data.aws_vpc.this
}
