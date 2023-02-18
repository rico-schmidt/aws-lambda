resource "aws_iam_role" "main" {
  name               = var.name
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": "Lambda execution role"
      }
    ]
  }
  EOF
}

resource "aws_iam_policy" "kms" {
  name        = data.aws_iam_policy_document.key.policy_id
  path        = "/"
  description = "KMS policy for Lambda ${aws_lambda_function.main.function_name}"
  policy      = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "kms:Decrypt",
        "Resource": "${var.lambda_kms_key}",
        "Effect": "Allow",
        "Sid": "Allow key usage"
      }
    ]
  }
  EOF
}

resource "aws_iam_policy" "cloudwatch" {
  name        = data.aws_iam_policy_document.key.policy_id
  path        = "/"
  description = "Cloudwatch policy for Lambda ${aws_lambda_function.main.function_name}"
  policy      = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "${aws_cloudwatch_log_group.main.arn}",
        "Effect": "Allow",
        "Sid": "Cloudwatch permissions"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "kms" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.kms.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.cloudwatch.arn
}