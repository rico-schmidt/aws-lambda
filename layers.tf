module "fastapi_layer" {
  source            = "./modules/lambda_layer"
  name              = "fastapi_layer"
  requirements_file = "api/requirements.txt"
}