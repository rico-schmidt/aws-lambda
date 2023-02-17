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

resource "aws_iam_policy" "kms" {
  name        = data.aws_iam_policy_document.key.policy_id
  path        = "/"
  description = "KMS policy for Lambda ${aws_lambda_function.main.function_name}"
  policy      = data.aws_iam_policy_document.key.json
}

resource "aws_iam_role_policy_attachment" "kms" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.kms.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}