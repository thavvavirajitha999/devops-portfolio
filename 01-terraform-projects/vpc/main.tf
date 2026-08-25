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
    region = var.region
  
}

# provider "aws" {
#     profile = "terraform"
#     region = "us-east-2"
#     alias = "aws-ohio"
# }

module "landing_zone" {
  source = "../modules/landing_zone"

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
      nat_required         = true
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

resource "aws_route" "private_route1" {
  route_table_id         = module.landing_zone.private_route_table_ids[0]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = module.landing_zone.nat_gateway_ids[0]
}

resource "aws_route" "private_route2" {
  route_table_id         = module.landing_zone.private_route_table_ids[1]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = module.landing_zone.nat_gateway_ids[1]
}

module "sg" {
    source = "../modules/security_group"
    vpc_id = module.landing_zone.vpc_id
    groupname = "vpc-sg"
    ingress_rules = [
        {
      protocol = "tcp"
      cidr = "106.200.29.79/32"
      from_port = 22
      to_port = 22
      type = "ingress"
    }
  ]
  
}

module "public-ec2-1a" {
  source = "../modules/ec2"
  ami = var.ami
  root_volume_encryption = true
  root_volume_size = 20
  root_volume_type = "gp3"
  instance_name = "vpc-instance-1a"
  instance_type = "t3.micro"
  security_groups = [module.sg.security_group_id]
  environment = var.environment
  subnet_id = module.landing_zone.private_subnet_ids_by_az["us-east-1a"]
  associate_public_ip_address = true
}

module "public-ec2-1b" {
  source = "../modules/ec2"
  ami = var.ami
  root_volume_encryption = true
  root_volume_size = 20
  root_volume_type = "gp3"
  instance_name = "vpc-instance-1b"
  instance_type = "t3.micro"
  security_groups = [module.sg.security_group_id]
  environment = var.environment
  subnet_id = module.landing_zone.private_subnet_ids_by_az["us-east-1b"]
  associate_public_ip_address = true
}