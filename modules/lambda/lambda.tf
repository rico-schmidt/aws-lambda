resource "aws_lambda_function" "main" {
  function_name    = var.name
  architectures    = var.architectures
  source_code_hash = data.archive_file.main.output_base64sha256
  role             = aws_iam_role.main.arn
  runtime          = var.runtime
  handler          = var.handler
  timeout          = var.timeout
  kms_key_arn      = aws_kms_key.main.arn

  s3_bucket         = data.aws_s3_bucket.main.id
  s3_key            = aws_s3_bucket_object.main.key
  s3_object_version = aws_s3_bucket_object.main.version_id
  memory_size       = var.memory_size
  layers            = var.lambda_layers

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
  package_type = var.package_type

  environment {
    variables = var.env_vars
  }

  #ephemeral_storage {
  #  size = var.lambda_storage_size # Min 512 MB and the Max 10240 MB
  #}

  #lifecycle {
  #  ignore_changes = [source_code_hash]
  #}

}

/*
resource "aws_lambda_alias" "lambda" {
  name             = var.name
  description      = ""
  function_name    = aws_lambda_function.main.function_name
  function_version = "$LATEST"
}

resource "aws_lambda_provisioned_concurrency_config" "main" {
  function_name                     = aws_lambda_alias.example.function_name
  provisioned_concurrent_executions = var.concurrency
  qualifier                         = aws_lambda_alias.example.name
}
*/