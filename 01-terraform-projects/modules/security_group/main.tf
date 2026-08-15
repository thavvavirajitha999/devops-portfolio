resource "aws_security_group" "res_sg" {
    name = var.groupname
    vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "res_sg_ingress" {
  security_group_id = aws_security_group.res_sg.id
  type = var.ingress_rules.type
  to_port = var.ingress_rules.to_port
  from_port = var.ingress_rules.from_port
  protocol = var.ingress_rules.protocol
  cidr_blocks = var.ingress_rules.cidr

}
