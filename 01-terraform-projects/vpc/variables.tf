##############vpc module variables

# variable "vpc_cidr" {
#   type = string
#   description = "CIDR block for the VPC"
# }

variable "igw_required" {
  type = bool
  description = "Enter true if want igw to be created for vpc module"
}

variable "environment" {
  type = string
  description = "Name of the environment"
}

variable "region" {
  type = string
  description = "Enter the region"
}

variable "ami" {
  type = string
  description = "Enter the ami id for the ec2"
}

variable "bucket" {
  type = string
  description = "Enter the name of the bucket to store the state"
}


# variable "public_subnets" {
#   description = "List of public subnets with cidr, name, route_table_required, route_table_name, public_route_required"
#   type = list(object({
#     cidr = string
#     name  = string
#     availability_zone = string
#     route_table_required = bool
#     public_route_required = bool
#     nat_required = bool
#   }))
# }


# variable "private_subnets" {
#   description = "List of private subnets with cidr, name, private_route_required, nat_gateway_name"
#   type = list(object({
#     cidr = string
#     name = string
#     availability_zone = string
#     route_table_required  = string
#     # private_route_required = bool
#   }))
# }

############ec2 module variables
# variable "ami" {
#     type = string
#     description = "Enter the ami id for the ec2"  
# }
# variable "instance_type" {
#     type = string
#     description = "Enter the ami id for the ec2"  
# }
# variable "instance_name" {
#    type = string
#    description = "Enter the name for the ec2" 
# }
# variable "environment" {
#    type = string
#    description = "Enter the name for the environment" 
# }
# variable "security_groups" {
#     type = list(string)
#     description = "Enter the sh ids to attach the instance"  
# }
# variable "subnet_id" {
#     type = string
#     description = "Enter the subnet id for the ec2"  
# }
# variable "associate_public_ip_address" {
#     type = bool
#     description = "Enter if you want the ec2 to have public ip or not"  
# }
# variable "root_volume_encryption" {
#     type = bool
#     description = "Enter if you want the root volume to be encrypted or not"  
# }
# variable "root_volume_type" {
#     type = string
#     description = "Enter the type of ebs volume"  
# }
# variable "root_volume_size" {
#     type = string
#     description = "Enter the size of ebs volume"  
# }

############sg module variables
# variable "vpc_id" {
#     type = string
#     description = "provide the vpc id in which the sg needs to be created"
# }
# variable "groupname" {
#     type = string
#     description = "Provide the security group name"
  
# }
# variable "ingress_rules" {
#     type = list(object({
#       protocol = string
#       cidr = string
#       from_port = number
#       to_port = number
#       type = string
#     }))
#     description = "Provide details for ingress rule"
# }