# Resources are only created if attached to Load Balancer

data "aws_alb" "main" {
  count = var.aws_alb_arn != null ? 1 : 0
  arn   = var.aws_alb_arn
}

resource "aws_alb_target_group" "main" {
  count       = length(data.aws_alb.main.*.arn)
  name        = var.name
  target_type = "lambda"
}

resource "aws_lambda_permission" "main" {
  count         = length(data.aws_alb.main.*.arn)
  statement_id  = "AllowExecutionFromlb"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.function_name
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_alb_target_group.main.*.arn
}

resource "aws_alb_target_group_attachment" "main" {
  count            = length(data.aws_alb.main.*.arn)
  target_group_arn = aws_lambda_permission.main.*.source_arn
  target_id        = aws_lambda_function.main.id
  port             = 443
}

resource "aws_lb_listener_rule" "main" {
  count        = length(data.aws_alb.main.*.arn)
  listener_arn = var.aws_alb_listener_arn
  #priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main.*.arn
  }

  condition {
    path_pattern {
      values = [var.alb_path]
    }
  }

  condition {
    http_request_method {
      values = var.http_request_methods
    }
  }
}