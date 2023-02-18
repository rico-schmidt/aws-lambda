variable "name" {
  type        = string
  description = "Name prefix for lambda function related resources"
}

variable "runtime" {
  type        = string
  default     = "python3.9"
  description = "Lambda function runtime"
}

variable "handler" {
  type        = string
  default     = "main.main"
  description = "Entry point for lambda function execution in format python_file.function"
}

variable "timeout" {
  type        = number
  default     = 10
  description = "Lambda function timeout in seconds"
}

variable "architectures" {
  type        = list(string)
  default     = ["x86_64"]
  description = "Architecture for lambda function"
}

variable "memory_size" {
  type        = number
  default     = 128
  description = "Memory allocated to Lambda function in MB"
}

variable "lambda_storage_size" {
  type        = number
  default     = 512
  description = "Size of ephemeral storage in MB"
}

variable "env_vars" {
  type        = map(string)
  description = "Environment variables present in lambda function code"
  default     = null
}

variable "source_dir" {
  type        = string
  description = "Relative path to source code directory for lambda function"
}

variable "provisioned_concurrency" {
  type        = number
  default     = null
  description = "Provisioned concurrency for lambda warm start executions"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "subnet IDs for lambda function"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security groups associated with lambda function"
  default     = null
}

variable "package_type" {
  type        = string
  default     = "Zip"
  description = "Lambda package type. Either Zip or Image"
}

variable "aws_alb_arn" {
  type        = string
  default     = null
  description = "AWS ALB ARN"
}

variable "aws_alb_listener_arn" {
  type        = string
  default     = null
  description = " Arn of AWS ALB Listener"
}

variable "alb_security_group_id" {
  type        = string
  default     = null
  description = "Load balancer security group ID"
}

variable "alb_path" {
  type        = string
  default     = null
  description = "Invoke path behind ALB"
}

variable "http_request_methods" {
  type        = list(string)
  default     = ["GET", "POST"]
  description = "List of allowed http request methods"
}

variable "bucket" {
  type        = string
  description = "Bucket that contains lambda source code files"
}

variable "lambda_layers" {
  type        = set(string)
  default     = []
  description = "IDs of lambda layers"
}

variable "lambda_kms_key" {
  type        = string
  description = "Lambda kms key ARN"
  default     = ""
}

variable "retention_in_days" {
  type        = number
  default     = 7
  description = "Log retention in cloudwatch"
}

variable "cloudwatch_kms_key" {
  type        = string
  default     = null
  description = "KMS key to encrypt cloudwatch log group"
}