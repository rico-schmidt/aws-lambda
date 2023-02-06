data "aws_iam_policy_document" "s3_get_object" {
  statement {
    effect  = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      "arn:aws:s3:::*"
    ]
  }
}

resource "aws_iam_policy" "s3_get_object" {
  name   = "${var.project}_get_s3_object"
  path   = "/"
  policy = data.aws_iam_policy_document.s3_get_object.json
}

/*
resource "aws_iam_role_policy_attachment" "s3_get_object" {
  role       = module.api.lambda_role_arn
  policy_arn = aws_iam_policy.s3_get_object.arn
}
*/