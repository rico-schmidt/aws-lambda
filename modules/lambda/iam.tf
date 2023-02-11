data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "main" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "main" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.main.json
}

data "aws_iam_policy_document" "key" {
  policy_id = "${var.name}_key"
  statement {
    sid    = "Allow key usage"
    effect = "Allow"
    actions = [
      "kms:Decrypt"
    ]
    resources = [
      var.lambda_kms_key
    ]
  }
}

