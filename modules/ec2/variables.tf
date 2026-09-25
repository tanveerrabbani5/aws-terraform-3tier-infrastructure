##    EC2 variables

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "private_app_subnet_id" {
  description = "Private application subnet where the EC2 instance will run"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the application EC2 instance"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile attached to the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}