data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "key" {
  policy_id = "${var.name}_key"
  /*
  statement {
    sid    = "Allow key usage"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        aws_s3_bucket.main.arn
      ]
    }
  }
  */
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
  }
}
