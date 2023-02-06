resource "aws_security_group" "main" {
  name        = "${var.name}_lb"
  description = "Security group for Load Balancer ${var.name}"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "http" {
  type              = "ingress"
  description       = "Allow ingress via HTTP"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "https" {
  type              = "ingress"
  description       = "Allow ingress via HTTPS"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
}

# Security group for LB egress to lambda
resource "aws_security_group_rule" "lambda" {
  security_group_id        = aws_security_group.main.id
  description              = "Egress from LB to lambda"
  type                     = "egress"
  from_port                = "443"
  to_port                  = "443"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nsg_lambda.id
}