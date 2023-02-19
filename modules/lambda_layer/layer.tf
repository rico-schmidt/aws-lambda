resource "aws_lambda_layer_version" "main" {
  layer_name        = var.name
  description       = "Lambda layer ${var.name}"
  s3_bucket         = data.aws_s3_bucket.main.id
  s3_key            = aws_s3_object.main.id
  s3_object_version = aws_s3_object.main.version_id

  compatible_architectures = [var.architecture]
  compatible_runtimes = [var.runtime]
  source_code_hash    = data.archive_file.main.output_base64sha256

  #lifecycle {
  #  ignore_changes = [source_code_hash]
  #}
}