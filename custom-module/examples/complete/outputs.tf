output "vpc" {
  value = module.vpc.vpc_id
}

output "public_subnet_output" {
  value = module.vpc.public_subnet
}

output "private_subnet_output" {
  value = module.vpc.private_subnet
}