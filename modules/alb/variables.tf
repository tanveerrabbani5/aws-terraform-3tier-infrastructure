##    ALB variable

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the ALB will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the Application Load Balancer"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the Application Load Balancer"
  type        = string
}


##    variable for Register the EC2 to the target group

variable "instance_id" {
  description = "ID of the application EC2 instance"
  type        = string
}