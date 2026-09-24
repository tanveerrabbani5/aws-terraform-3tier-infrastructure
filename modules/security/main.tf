##   ALB Security Group

resource "aws_security_group" "alb" {
  name        = "three-tier-${var.environment}-alb-sg"
  description = "Security group for the Application Load Balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "three-tier-${var.environment}-alb-sg"
    Tier = "Public"
  }
}


##    ALB inbound HTTP

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id

  description = "Allow HTTP traffic from the internet"

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  cidr_ipv4 = "0.0.0.0/0"
}


##    ALB inbound HTTPS

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id

  description = "Allow HTTPS traffic from the internet"

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  cidr_ipv4 = "0.0.0.0/0"
}


##    ALB outbound traffic

resource "aws_vpc_security_group_egress_rule" "alb_all" {
  security_group_id = aws_security_group.alb.id

  description = "Allow outbound traffic"

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}


##    Application Security Group

resource "aws_security_group" "app" {
  name        = "three-tier-${var.environment}-app-sg"
  description = "Security group for application servers"
  vpc_id      = var.vpc_id

  tags = {
    Name = "three-tier-${var.environment}-app-sg"
    Tier = "Private-App"
  }
}


##    Allow application traffic from the ALB

resource "aws_vpc_security_group_ingress_rule" "app_from_alb" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.alb.id

  description = "Allow application traffic from the ALB"

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}


##    Application outbound

resource "aws_vpc_security_group_egress_rule" "app_all" {
  security_group_id = aws_security_group.app.id

  description = "Allow outbound traffic"

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}


##    Database Security Group

resource "aws_security_group" "db" {
  name        = "three-tier-${var.environment}-db-sg"
  description = "Security group for database"
  vpc_id      = var.vpc_id

  tags = {
    Name = "three-tier-${var.environment}-db-sg"
    Tier = "Private-DB"
  }
}


##    Allow MySQL only from the App SG

resource "aws_vpc_security_group_ingress_rule" "db_from_app" {
  security_group_id            = aws_security_group.db.id
  referenced_security_group_id = aws_security_group.app.id

  description = "Allow MySQL traffic from application servers"

  ip_protocol = "tcp"
  from_port   = 3306
  to_port     = 3306
}


##    DB outbound

resource "aws_vpc_security_group_egress_rule" "db_all" {
  security_group_id = aws_security_group.db.id

  description = "Allow outbound traffic"

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
