terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }

  required_version = ">= 0.14.9"

  backend "s3" {
    bucket  = "risc-terraform"
    key     = "terraform/api/terraform.tfstate"
    region  = "eu-central-1"
    profile = "risc-vpc"
  }
}

provider "aws" {
  region  = var.region
  profile = "risc-vpc"
  default_tags {
    tags = {
      Project   = var.project
      Terraform = "true"
      Stage     = var.stage
    }
  }
}