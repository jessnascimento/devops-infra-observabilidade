terraform {
  required_version = ">= 1.10.0, < 2.0.0"

  backend "s3" {
    key          = "projeto-observabilidade/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
