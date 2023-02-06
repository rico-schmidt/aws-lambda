data "archive_file" "main" {
  type        = "zip"
  output_path = "${path.root}/.terraform/tmp/${var.name}.zip"
  source_dir  = var.source_dir
}

data "aws_s3_bucket" "main" {
  bucket = var.bucket
}

#upload zip to S3
resource "aws_s3_bucket_object" "main" {
  bucket = data.aws_s3_bucket.main.id
  key    = "/lambda/${var.name}/source"
  source = data.archive_file.main.id
  etag   = filemd5("path/to/file")
}