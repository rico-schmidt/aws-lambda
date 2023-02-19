resource "aws_lambda_function" "main" {
  function_name    = var.name
  architectures    = [var.architecture]
  source_code_hash = data.archive_file.main.output_base64sha256
  role             = aws_iam_role.main.arn
  runtime          = var.runtime
  handler          = var.handler
  timeout          = var.timeout
  kms_key_arn      = var.lambda_kms_key

  s3_bucket                      = data.aws_s3_bucket.main.id
  s3_key                         = aws_s3_object.main.id
  s3_object_version              = aws_s3_object.main.version_id
  memory_size                    = var.memory_size
  layers                         = var.lambda_layers
  reserved_concurrent_executions = var.reserved_concurrency

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = concat(try([aws_security_group.main[0].id], []), var.security_group_ids)
  }
  package_type = var.package_type

  environment {
    variables = var.env_vars
  }

  #ephemeral_storage {
  #  size = var.lambda_storage_size # Min 512 MB and the Max 10240 MB
  #}
}

/*
resource "aws_lambda_alias" "lambda" {
  name             = var.name
  description      = ""
  function_name    = aws_lambda_function.main.function_name
  function_version = "$LATEST"
}
*/

# Manages provisioned concurrency for hot start
resource "aws_lambda_provisioned_concurrency_config" "main" {
  count                             = var.provisioned_concurrency == null ? 0 : 1
  function_name                     = aws_lambda_function.main.function_name
  provisioned_concurrent_executions = var.provisioned_concurrency
  qualifier                         = aws_lambda_function.main.function_name
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/lambda/${aws_lambda_function.main.function_name}"
  retention_in_days = var.retention_in_days
  kms_key_id        = var.cloudwatch_kms_key
}