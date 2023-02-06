resource "aws_kms_key" "main" {
  description              = "KMS key for S3 bucket ${var.name}"
  customer_master_key_spec = var.key_spec
  is_enabled               = true
  enable_key_rotation      = var.rotation_enabled
  policy                   = data.aws_iam_policy_document.key.json
  deletion_window_in_days  = var.deletion_window_in_days
  tags                     = var.key_tags
}

resource "aws_kms_alias" "main" {
  name          = "alias/${var.name}_s3_key"
  target_key_id = aws_kms_key.main.key_id
}