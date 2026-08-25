variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC"
}

variable "igw_required" {
  type = bool
  description = "Enter true if you want igw created"
}

variable "public_subnets" {
  description = "List of public subnets with cidr, name, route_table_required, route_table_name, public_route_required"
  type = list(object({
    cidr = string
    name  = string
    availability_zone = string
    route_table_required = bool
    public_route_required = bool
    nat_required = bool
  }))
}


variable "private_subnets" {
  description = "List of private subnets with cidr, name, private_route_required, nat_gateway_name"
  type = list(object({
    cidr = string
    name = string
    availability_zone = string
    route_table_required  = string
    # private_route_required = bool
  }))
}
