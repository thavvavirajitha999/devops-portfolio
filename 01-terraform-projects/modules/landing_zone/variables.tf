variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "igw_required" {
  type        = bool
  description = "Whether to create an Internet Gateway"
}

variable "public_subnets" {
  description = "List of public subnets with cidr, name, route_table_required, route_table_name, public_route_required"
  type = list(object({
    cidr                 = string
    name                 = string
    availability_zone     = string
    route_table_required = bool
    route_table_name     = string
    public_route_required = bool
  }))
}

variable "nat_required" {
  type        = bool
  description = "Whether to create NAT Gateways"
}

variable "nat_gateways" {
  description = "List of NAT gateways with subnet and eip_required"
  type = list(object({
    subnet_id   = string
    eip_required = bool
    name        = string
  }))
}

variable "private_subnets" {
  description = "List of private subnets with cidr, name, private_route_required, nat_gateway_name"
  type = list(object({
    cidr                  = string
    name                  = string
    availability_zone     = string
    private_route_required = bool
    nat_gateway_name      = string
  }))
}
