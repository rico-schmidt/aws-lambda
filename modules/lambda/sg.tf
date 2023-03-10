resource "aws_security_group" "main" {
  count       = length(var.subnet_ids) > 0 ? 1 : 0
  name        = "${var.name}_lambda"
  description = "Lambda security group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "internet_eg" {
  count             = length(var.subnet_ids) > 0 ? 1 : 0
  security_group_id = aws_security_group.main.*.id
  description       = "Allows lambda to establish connections to all resources"
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Ingress from Load Balancer
resource "aws_security_group_rule" "lb_ig" {
  count                    = length(var.subnet_ids) > 0 && length(data.aws_alb.main.*.arn) > 0 ? 1 : 0
  security_group_id        = aws_security_group.main.*.id
  description              = "Allow ingress from Load Balancer"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = var.alb_security_group_id
}