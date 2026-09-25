##    Add Security output

output "app_security_group_id" {
  description = "Security group ID for application servers"
  value       = aws_security_group.app.id
}


