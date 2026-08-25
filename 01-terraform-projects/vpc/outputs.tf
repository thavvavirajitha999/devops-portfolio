output "vpc_id" {
  value = module.landing_zone.vpc_id
}

output "public_subnet_ids" {
  value = module.landing_zone.public_subnet_ids_by_az
}

output "private_subnet_ids_by_az" {
  value = module.landing_zone.private_subnet_ids_by_az
}

# output "nat_gateway_ids" {
#     value = module.landing_zone.nat_gateway_ids_by_az
# }

output "internet_gateway_id" {
  value = module.landing_zone.internet_gateway_id
}
output "sg-id" {
    value = module.sg.security_group_id
  
}
output "ec2-id-1a" {
    value = module.public-ec2-1a.Instance_id
  
}
output "ec2-id-1b" {
    value = module.public-ec2-1b.Instance_id
  
}
output "ec2-ip-1a" {
    value = module.public-ec2-1a.Instance_publicip
}
output "ec2-ip-1b" {
    value = module.public-ec2-1b.Instance_publicip
}
