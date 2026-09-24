resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "three-tier-${var.environment}-vpc"
  }
}


resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "three-tier-${var.environment}-public-${count.index + 1}"
    Tier = "Public"
  }
}

resource "aws_subnet" "private_app" {
  count = length(var.private_app_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_app_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "three-tier-${var.environment}-private-app-${count.index + 1}"
    Tier = "Private-App"
  }
}

resource "aws_subnet" "private_db" {
  count = length(var.private_db_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_db_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "three-tier-${var.environment}-private-db-${count.index + 1}"
    Tier = "Private-DB"
  }
}


resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "three-tier-${var.environment}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "three-tier-${var.environment}-public-rt"
    Tier = "Public"
  }
}


resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}


resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "private_db" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "three-tier-${var.environment}-private-db-rt"
    Tier = "Private-DB"
  }
}


resource "aws_route_table_association" "private_db" {
  count = length(var.private_db_subnet_cidrs)

  subnet_id      = aws_subnet.private_db[count.index].id
  route_table_id = aws_route_table.private_db.id
}


resource "aws_route_table" "private_app" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "three-tier-${var.environment}-private-app-rt"
    Tier = "Private-App"
  }
}


resource "aws_route_table_association" "private_app" {
  count = length(var.private_app_subnet_cidrs)

  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.private_app.id
}