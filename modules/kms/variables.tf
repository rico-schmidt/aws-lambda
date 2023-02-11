variable "name" {
  type        = string
  description = "Name prefix for lambda function related resources"
}

variable "rotation_enabled" {
  type        = bool
  description = "Boolean to enable automatic key rotation"
  default     = true
}

variable "key_tags" {
  type        = map(string)
  description = "KMS Key tags"
  default     = null
}

variable "key_spec" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  description = "Key algorithm"
}

variable "deletion_window_in_days" {
  type        = number
  default     = 7
  description = "Deletion period for KMS key"
}