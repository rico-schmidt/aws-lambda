module "fastapi_layer" {
  source            = "./modules/lambda_layer"
  name              = "fastapi_layer"
  bucket            = module.s3.bucket_id
  requirements_file = "api/requirements.txt"
}