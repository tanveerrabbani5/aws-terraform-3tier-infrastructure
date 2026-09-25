##    Create EC2

resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = var.private_app_subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  iam_instance_profile = var.instance_profile_name

  associate_public_ip_address = false

  tags = {
    Name        = "three-tier-${var.environment}-app"
    Tier        = "Private-App"
    Environment = var.environment
  }
}


