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


##    create Target Group

resource "aws_lb_target_group" "app" {
  name     = "three-tier-${var.environment}-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  target_type = "instance"

  health_check {
    enabled  = true
    protocol = "HTTP"
    path     = "/"
    port     = "traffic-port"
  }

  tags = {
    Name = "three-tier-${var.environment}-app-tg"
  }
}