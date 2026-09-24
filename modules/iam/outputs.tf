##    output for IAM Instance Profile

output "ec2_instance_profile_name" {
  description = "IAM instance profile name for EC2"
  value       = aws_iam_instance_profile.ec2.name
}