output "instance_id" {
  description = "Id of the Ec2 instance"
  value = aws_instance.Test_ins2.id
}
output "pulic_ip" {
    description = "Ip of the instance created"
    value = aws_instance.Test_ins2.public_ip
}