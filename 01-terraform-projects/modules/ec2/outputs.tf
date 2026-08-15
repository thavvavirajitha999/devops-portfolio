output "Instance_privateip" {
  description = "The private ip of the instance created"
  value = aws_instance.res_instance.private_ip
}
output "Instance_id" {
  description = "The id of the instance created"
  value = aws_instance.res_instance.id
}
output "Instance_publicip" {
    description = "The public instance id of the ec2 is assigned"
    value = aws_instance.res_instance.public_ip
  
}