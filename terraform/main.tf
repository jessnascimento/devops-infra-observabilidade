data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

locals {
  project_name = var.project_name

  common_tags = {
    Project     = local.project_name
    Environment = "academic"
    ManagedBy   = "Terraform"
  }
}
