##    create the EC2 trust relationship by role

resource "aws_iam_role" "ec2" {
  name = "three-tier-${var.environment}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "three-tier-${var.environment}-ec2-role"
  }
}


##    IAM Instance Profile  ----  EC2-->Profile-->role-->AWS Permission

resource "aws_iam_instance_profile" "ec2" {
  name = "three-tier-${var.environment}-ec2-profile"
  role = aws_iam_role.ec2.name

  tags = {
    Name = "three-tier-${var.environment}-ec2-profile"
  }
}


##    SSM permission to the IAM role

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


