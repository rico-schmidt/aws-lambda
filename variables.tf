variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "project" {
  type        = string
  description = "Project identifier"
}

variable "stage" {
  type        = string
  description = "Project stage"
  default     = "dev"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}


variable "api_name" {
  type        = string
  description = "Name of Lambda API"
}

variable "runtime" {
  type        = string
  description = "Lambda runtime"
  default     = "python3.9"
}

variable "services" {
  type        = set(string)
  description = "Name of AWS Services like lambda, ec2"
  default     = []
}