data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "main" {
  policy_id = "${var.name}_default"
  statement {
    sid     = "Enable IAM policies"
    effect  = "Allow"
    actions = ["kms:*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    resources = ["*"]
  }
}