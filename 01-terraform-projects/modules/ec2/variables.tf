variable "ami" {
    type = string
    description = "Provide the ami id for your ec2 instance"
  
}
variable "subnet_id" {
    description = "Provide the subnet id in which the instance needs to be launched"
    type = string
  
}
variable "associate_public_ip_address" {
    description = "Choose whether to associate your instance with a public id"
    type = string
  
}
variable "instance_name" {
  description = "Provide the name of your ec2 instance"
  type = string
}
variable "instance_type" {
    type = string
    description = "Provide the instance type for the ec2 instance"
    default = "t3.micro"
    validation {
    # Checks if the user input exists within the provided list
    condition     = contains(["t3.micro", "t2.micro"], var.instance_type)
    error_message = "The instance type must be t3.micro, t2.micro"
  }
}
variable "root_volume_encryption" {
    description = "Provide true encryption is needed else provide false"
    type = bool
  
}
variable "root_volume_size" {
    description = "Provide the size of root volume in GiB"
    type = number
  
}
variable "root_volume_type" {
    description = "Provide the type of root volume"
    type = string
    default = "gp3"
}
variable "security_groups" {
    description = "Provide the list of security gorups to attach to an instance"
    type = list(string)
}

variable "environment" {
  description = "Provide the environment in which you are creating the instance"
  validation {
    condition = contains(["dev", "qa", "prod"], var.environment)
    error_message = "The allowed values for environment are dev, qa and prod"
  }
}
