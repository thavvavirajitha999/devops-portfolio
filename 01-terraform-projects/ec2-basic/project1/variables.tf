variable "instance_type" {
  type        = string
  description = "EC2 instance type for the web server"
  default     = "t3.micro"
}
variable "ami" {
  type        = string
  description = "AMI id to be used for the instance"
  # default     = "ami-**********"
}
variable "myip"{
  type = string
  description = "Enter your ip address to allow ssh to your ec2"
}