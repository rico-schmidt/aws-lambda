variable "name" {
  type        = string
  description = "Name prefix for lambda function related resources"
}

variable "runtime" {
  type        = string
  default     = "python3.9"
  description = "Lambda function runtime"
}

variable "source_dir" {
  type        = string
  description = "Relative path to source code directory for lambda function"
}

variable "bucket" {
  type        = string
  description = "Bucket that contains lambda source code files"
}