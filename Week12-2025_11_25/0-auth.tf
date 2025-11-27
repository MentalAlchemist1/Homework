# Terraform configuration block
# This defines the minimum Terraform version and required providers
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "shadow-titan-s3bucket"
    key    = "class7/theshadows/S3BackendDemo.tfstate"
    region  = "us-east-2"
  }
}


# AWS Provider configurationd
# This tells Terraform how to connect to AWS
provider "aws" {
  region  = "us-west-2"
  profile = "default"

  # # Default tags are applied to all resources created by this provider
  # default_tags {
  #   tags = {
  #     Project     = "vpc-demo"
  #     Environment = "dev"
  #     ManagedBy   = "Terraform"
  #   }
  # }
}