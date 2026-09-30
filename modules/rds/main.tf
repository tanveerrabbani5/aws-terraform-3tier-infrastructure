##    Configure the database

resource "aws_db_subnet_group" "this" {
  name       = "three-tier-${var.environment}-db-subnet-group"
  subnet_ids = var.private_db_subnet_ids

  tags = {
    Name = "three-tier-${var.environment}-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier = "three-tier-${var.environment}-mysql"

  engine         = "mysql"
  instance_class = var.instance_class

  allocated_storage     = 20
  max_allocated_storage = 20
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = 3306

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.security_group_id]

  publicly_accessible = false
  multi_az            = false

  backup_retention_period = 1
  deletion_protection     = false
  skip_final_snapshot     = true

  tags = {
    Name        = "three-tier-${var.environment}-mysql"
    Environment = var.environment
    Tier        = "Private-DB"
  }
}