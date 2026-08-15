output "security_group_id" {
    description = "The id of security group created "
    type = string
    value = aws_security_group.res_sg.id
}