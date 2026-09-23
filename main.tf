data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr    = "10.0.0.0/16"
  environment = var.environment
}

output "aws_account_id" {
  description = "AWS account ID being used by Terraform"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  description = "AWS region being used by Terraform"
  value       = data.aws_region.current.region
}


output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}