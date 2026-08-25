resource "aws_security_group" "res_sg" {
    name = var.groupname
    vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "res_sg_ingress" {
  for_each = { for s, rule in var.ingress_rules : s => rule }

  security_group_id = aws_security_group.res_sg.id
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr]
}

