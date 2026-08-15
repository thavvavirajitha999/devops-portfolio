terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.15.0"
}

# Configure the AWS Provider
# provider "aws" {
#   profile = "terraform"
#   region  = "us-east-1"
# }

resource "aws_security_group" "ssh_sg" {
  name        = "ssh-sg"
  description = "Allows SSH traffic to the Ec2 from my local ip"
  vpc_id      = data.aws_vpc.selected.id
  
  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.ssh_sg.id
  cidr_ipv4 = "${var.myip}/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Create an EC2 instance
resource "aws_instance" "test_ins_1" {
  ami  = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ssh_sg.id]
  subnet_id = data.aws_subnets.subnet.ids[0]
  tags = {
    Name = "TestInstance"
  }
}
