variable "instance_type" {
  type        = string
  description = "The size of the virtual machine instance."
}

variable "environment" {
  type        =  string
}

variable "subnet"{ 
    type = string
    description = "Subnet launch the instance in"
 }

variable "region" {
    type = string
    description = "Region of your AWS account"
}

variable "ami_id" {
  type = string
  description = "Provide the ami id to be used for the ec2"
  
}