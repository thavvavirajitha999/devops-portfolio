# This module can be used to create a landind Zone which creates a vpc, its subnets, route tables, IGW and NAT gateway

modules
└── landing zone
    ├── README.md
    ├── main.tf
    ├── outputs.tf
    ├── variables.tf

## Landing zone Module:
This modules alllowes you to create an entire vpc with public and private subnets, IGW, NAT gateways, Route tables and other resources

example reference to this module:
module "landing zone" {
  source = "./modules/landing_zone"
  vpc_cidr     = var.vpc_cidr
  igw_required = var.igw_required

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  }
### variable file for this module:
  
vpc_cidr     = "10.0.0.0/16"
  igw_required = true

  public_subnets = [
    {
      cidr                 = "10.0.1.0/24"
      name                 = "public-subnet-1"
      availability_zone    = "us-east-1a"
      route_table_required = true
      public_route_required = true
      nat_required         = true
    },
    {
      cidr                 = "10.0.2.0/24"
      name                 = "public-subnet-2"
      availability_zone    = "us-east-1b"
      route_table_required = true
      public_route_required = true
      nat_required         = false
    }
  ]

  private_subnets = [
    {
      cidr                  = "10.0.3.0/24"
      name                  = "private-subnet-1"
      availability_zone     = "us-east-1a"
      route_table_required  = "yes"
      private_route_required = true
    },
    {
      cidr                  = "10.0.4.0/24"
      name                  = "private-subnet-2"
      availability_zone     = "us-east-1b"
      route_table_required  = "yes"
      private_route_required = true
    }
  ]

## or 

module "network" {
  source = "./modules/vpc-module"

  vpc_cidr     = "10.0.0.0/16"
  igw_required = true

  public_subnets = [
    {
      cidr                 = "10.0.1.0/24"
      name                 = "public-subnet-1"
      availability_zone    = "us-east-1a"
      route_table_required = true
      public_route_required = true
      nat_required         = true
    },
    {
      cidr                 = "10.0.2.0/24"
      name                 = "public-subnet-2"
      availability_zone    = "us-east-1b"
      route_table_required = true
      public_route_required = true
      nat_required         = false
    }
  ]

  private_subnets = [
    {
      cidr                  = "10.0.3.0/24"
      name                  = "private-subnet-1"
      availability_zone     = "us-east-1a"
      route_table_required  = "yes"
      private_route_required = true
    },
    {
      cidr                  = "10.0.4.0/24"
      name                  = "private-subnet-2"
      availability_zone     = "us-east-1b"
      route_table_required  = "yes"
      private_route_required = true
    }
  ]
}


### Example output file

output "vpc_id" {
  value = module.landing_zone.vpc_id
}

output "public_subnet_ids" {
  value = module.landing_zone.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.landing_zone.private_subnet_ids
}



