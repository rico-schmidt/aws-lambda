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