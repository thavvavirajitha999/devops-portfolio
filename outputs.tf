output "vpc_id" {
  value = module.landing_zone.vpc_id
}

output "public_subnet_ids" {
  value = module.landing_zone.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.landing_zone.private_subnet_ids
}