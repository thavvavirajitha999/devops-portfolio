resource "aws_instance" res_instance {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = var.security_groups
  subnet_id = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address

  root_block_device {
    delete_on_termination = true
    encrypted = var.root_volume_encryption
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
  }
  tags = {
    Name = var.instance_name
    environment = var.environment
  }
}