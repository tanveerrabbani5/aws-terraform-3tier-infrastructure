provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "AWS 3-Tier Infrastructure"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Tanveer Rabbani"
    }
  }
}