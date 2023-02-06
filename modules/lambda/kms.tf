# Creates/manages KMS CMK
resource "aws_kms_key" "main" {
  description              = "KMS key for lambda function ${var.name}"
  customer_master_key_spec = var.key_spec
  is_enabled               = true
  enable_key_rotation      = var.rotation_enabled
  policy                   = data.aws_iam_policy_document.key.json
  deletion_window_in_days  = var.deletion_window_in_days
  tags                     = var.key_tags
}

# Add an alias to the key
resource "aws_kms_alias" "main" {
  name          = "alias/${var.name}_lambda"
  target_key_id = aws_kms_key.main.key_id
}