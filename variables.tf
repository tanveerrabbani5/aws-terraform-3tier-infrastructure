variable "aws_region" {
  description = "AWS region where the infrastructure will be deployed"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}


##     variable db_password

variable "db_password" {
  description = "Master password for the RDS database"
  type        = string
  sensitive   = true
}