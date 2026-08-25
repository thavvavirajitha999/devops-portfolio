output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids_by_az" {
  description = "Map of AZ → Public Subnet ID"
  value       = { for s in aws_subnet.public : s.availability_zone => s.id }
}

output "private_subnet_ids_by_az" {
  description = "Map of AZ → Private Subnet ID"
  value       = { for s in aws_subnet.private : s.availability_zone => s.id }
}

output "private_route_table_ids" {
  value = [for r in aws_route_table.private : r.id]
}

output "nat_gateway_ids" {
  value = [for n in aws_nat_gateway.this : n.id]
  
}

##since nat dont have az attribute we will use az attribute of the subnet in which it is created
# output "nat_gateway_ids_by_az" {
#   description = "Map of AZ → NAT Gateway ID"
#   value = {
#     for n in aws_nat_gateway.this :
#     aws_subnet.public[n.subnet_id].availability_zone => n.id
#   }
# }

#since rt dont have az attribute we will use the az attribute if the association
# output "private_route_table_ids_by_az" {
#   description = "Map of AZ → Private Route Table ID"
#   value = {
#     for assoc in aws_route_table_association.private :
#     aws_subnet.private[assoc.subnet_id].availability_zone => assoc.route_table_id
#   }
# }

output "internet_gateway_id" {
  value = var.igw_required ? aws_internet_gateway.this[0].id : null
}
