# Fetching ami id from AWs console which is most recent owned by me, with name mentioned in 
# filter, have the tags set as mentioned below
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  required_version = ">=1.15.0"
}

provider "aws" {
  region = var.region
  profile = "terraform"

}

#Created an Ec2 instance with name test_ins
resource "aws_instance" "Test_ins2" {
  ami = var.ami_id
  subnet_id = var.subnet
  instance_type = var.instance_type
  tags = {
    key = "environment"
    value = var.environment
  } 
}
