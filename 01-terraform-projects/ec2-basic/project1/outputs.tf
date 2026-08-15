output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.test_ins_1.id
}

output "instance_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.test_ins_1.public_ip
}