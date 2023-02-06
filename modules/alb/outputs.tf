output "aws_alb_arn" {
  value = aws_alb.main.arn
}

output "aws_alb_listener_arn" {
  value = aws_alb_listener.https.arn
}