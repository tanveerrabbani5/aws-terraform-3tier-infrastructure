##    create ALB 

resource "aws_lb" "this" {
  name               = "three-tier-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    var.security_group_id
  ]

  subnets = var.public_subnet_ids

  tags = {
    Name = "three-tier-${var.environment}-alb"
  }
}