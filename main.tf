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
  source = "./modules/kms"
  name = each.key
}

module "api" {
  source             = "./modules/lambda"
  name               = var.api_name
  source_dir         = "${path.root}/code/api"
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids
  env_vars = {
    stage = "dev"
  }
  vpc_id = var.vpc_id
  bucket = module.s3.bucket_id
  #aws_alb_arn = module.alb.aws_alb_arn
  #aws_alb_listener_arn = module.alb.aws_alb_listener_arn
  #alb_security_group_id = module.alb.security_group_id
}