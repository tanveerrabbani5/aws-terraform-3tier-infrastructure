variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}