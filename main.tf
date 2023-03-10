data "aws_subnets" "main" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Tier = "private"
  }
}

module "s3" {
  source = "./modules/s3_bucket"
  name   = "${var.project}-${var.stage}-s3"
}

/*
module "alb" {
  source = "./modules/alb"
  name = "risc-alb"
}
*/

module "kms" {
  for_each = var.services
  source   = "./modules/kms"
  name     = each.key
}

module "api_lambda" {
  source             = "./modules/lambda"
  name               = var.api_name
  source_dir         = "${path.root}/code/api"
  subnet_ids         = [] #data.aws_subnets.main.ids
  security_group_ids = var.security_group_ids
  env_vars = {
    stage = var.stage
  }
  vpc_id             = var.vpc_id
  bucket             = module.s3.bucket_id
  lambda_kms_key     = module.kms["lambda"].kms_key_arn
  cloudwatch_kms_key = module.kms["cloudwatch"].kms_key_arn
  lambda_layers      = [module.fastapi_layer.arn]
  #aws_alb_arn = module.alb.aws_alb_arn
  #aws_alb_listener_arn = module.alb.aws_alb_listener_arn
  #alb_security_group_id = module.alb.security_group_id
}