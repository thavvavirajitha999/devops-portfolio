# This module creates an ec2
Example reference:
module "ec2_instance" {
  source = "./modules/ec2"
  ami = "ami-**********"
  subnet = "sub-***********"
  associate_public_ip_address = true
  instance_name = "ec2-module-test"
  instance_type = t2.small
  root_volume_encryption = true
  root_volume_size = 20
  root_volume_type = gp3
  security_groups = ["sg-*************", "sg-*****************"]
  environment = dev
}


# output refrence:
output "Instance_privateip" {
  description = "The private ip of the instance created"
  value = module.ec2_instance.res_instance.private_ip
}
output "Instance_id" {
  description = "The id of the instance created"
  value = aws_instance.ec2_instance.id
}
output "Instance_publicip" {
    description = "The public instance id of the ec2 is assigned"
    value = aws_instance.ec2_instance.public_ip
  
}