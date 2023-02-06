resource "aws_alb" "main" {
  name                       = var.name
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = var.security_groups
  subnets                    = var.subnet_ids
  ip_address_type            = "ipv4"
  enable_deletion_protection = true

  /*
 # replace by dynamic block
  subnet_mapping {
    subnet_id            = aws_subnet.example1.id
    private_ipv4_address = "10.0.1.15"
  }

  subnet_mapping {
    subnet_id            = aws_subnet.example2.id
    private_ipv4_address = "10.0.2.15"
  }
  */

  /*
    # configure access logs
  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  }
  */
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.main.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.main.id
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.cert.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main.id
  }
}