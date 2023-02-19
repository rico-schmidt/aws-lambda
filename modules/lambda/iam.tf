data "aws_iam_policy_document" "main" {
  statement {
    actions    = ["sts:AssumeRole"]
    effect     = "Allow"
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

data "aws_iam_policy_document" "kms" {
  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
    ]
    resources = [
      var.lambda_kms_key,
    ]
  }
}

resource "aws_iam_policy" "kms" {
  name        = "${var.name}KmsPolicy"
  path        = "/"
  description = "KMS policy for Lambda ${aws_lambda_function.main.function_name}"
  policy      = data.aws_iam_policy_document.kms.json
}

data "aws_iam_policy_document" "cloudwatch" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      aws_cloudwatch_log_group.main.arn,
    ]
  }
}

resource "aws_iam_policy" "cloudwatch" {
  name        = "${var.name}CloudwatchPolicy"
  path        = "/"
  description = "Cloudwatch policy for Lambda ${aws_lambda_function.main.function_name}"
  policy      = data.aws_iam_policy_document.cloudwatch.json
}

resource "aws_iam_role_policy_attachment" "kms" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.kms.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.cloudwatch.arn
}