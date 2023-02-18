locals {
  target_path       = "${abspath(path.root)}/.python/${var.name}"
  requirements_file = "${abspath(path.root)}/code/${var.requirements_file}"
  python_version    = trim_prefix(var.runtime, "python")
  platform = {
    "arm64" = "manylinux2014_aarch64"
  "x86" = "manylinux2014_x86_64" }[var.platform]
}

resource "null_resource" "build" {
  triggers = {
    run = timestamp()
  }

  provisioner "local-exec" {
    command = "${path.module}/build.sh"
    environment = {
      TARGET_PATH    = local.target_path
      PACKAGE_FILE   = local.requirements_file
      PYTHON_VERSION = local.python_version
      PLATFORM       = local.platform
    }
  }
}

data "archive_file" "main" {
  type        = "zip"
  output_path = "${path.root}/.terraform/tmp/${var.name}.zip"
  source_dir  = local.target_path
  depends_on = [
    null_resource.build
  ]
}

data "aws_s3_bucket" "main" {
  bucket = var.bucket
}

#upload zip to S3
resource "aws_s3_object" "main" {
  bucket = data.aws_s3_bucket.main.id
  key    = "/lambda_layer/${var.name}/source"
  source = data.archive_file.main.id
}