variable "vpc_id" {
    type = string
    description = "provide the vpc id in which the sg needs to be created"
}
variable "groupname" {
    type = string
    description = "Provide the security group name"
  
}
variable "ingress_rules" {
    type = list(object({
      protocol = string
      cidr = string
      from_port = number
      to_port = number
      type = string
    }))
    description = "Provide details for ingress rule"
}

