output "arn" {
  value = aws_lambda_layer_version.main.arn
}

output "layer_arn" {
  value = aws_lambda_layer_version.main.layer_arn
}

output "layer_name" {
  value = aws_lambda_layer_version.main.layer_name
}