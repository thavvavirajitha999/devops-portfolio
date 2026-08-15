# This a module for creating an Sg
example reference for this module 

module sg{
    source = ./modules/security_group
    vpc_id    = "vpc-1234567890abcdef"
    groupname = "web-sg"

    ingress_rules = [
    {
        protocol   = "tcp"
        cidr       = "0.0.0.0/0"
        from_port  = 22
        to_port    = 22
        type       = "ingress"
    },
    {
        protocol   = "tcp"
        cidr       = "0.0.0.0/0"
        from_port  = 80
        to_port    = 80
        type       = "ingress"
    }
    ]
}

# example output

output "security_group_id" {
    description = "The id of security group created "
    type = string
    value = module.sg.security_group_id
}
