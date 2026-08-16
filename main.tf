terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.15.0"
}

provider "aws" {
    profile = "terraform"
    region = "us-east-1"
  
}

# provider "aws" {
#     profile = "terraform"
#     region = "us-east-2"
#     alias = "aws-ohio"
# }

module "landing_zone" {
  source = "./modules/landing_zone"

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
    },
    {
      cidr                  = "10.0.4.0/24"
      name                  = "private-subnet-2"
      availability_zone     = "us-east-1b"
      route_table_required  = "yes"
    }
  ]
}