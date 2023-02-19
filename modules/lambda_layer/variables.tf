variable "name" {
  type        = string
  description = "Name prefix for lambda layer related resources"
}

variable "runtime" {
  type        = string
  default     = "python3.9"
  description = "Lambda layer compatible runtimes"
}

variable "architecture" {
  type        = string
  default     = "arm64"
  description = "Architecture platform"
  validation {
    condition     = contains(["arm64", "x86_64"], var.architecture)
    error_message = "Platform must be in [arm64, x86_64]."
  }
}

variable "requirements_file" {
  type        = string
  description = "Relative path to requirements.txt file for lambda layer"
}

variable "bucket" {
  type        = string
  description = "Bucket that stores lambda layer source code files"
}