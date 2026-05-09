terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 6.37.0"
    }
  }

backend "s3" {
  bucket = "linga-devops-rs"
  key = "ansible-tf-master-agents"
  region = "us-east-1"
  dynamodb_table="linga-devops-locking"
  }
}
#provide authentication here
provider "aws" {
  # Configuration options
  region = "us-east-1"
}

