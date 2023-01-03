terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
data "aws_availability_zones" "available" {}

# Create private subnets in two availability zone
resource "aws_subnet" "private_subnets" {
  count       = length(var.private_subnet_cidr)
  vpc_id            = var.vpc_id
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
}
# Create public subnets in two availability zone
resource "aws_subnet" "public_subnets" {
 count       = length(var.public_subnet_cidr)
  vpc_id            = var.vpc_id
  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
}

# Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "default-internet-gateway"
  }
}

# Create route table
resource "aws_route_table" "defaut-route-table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "defaut-route-table"
  }
}

# Associate route table with public subnets
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.defaut-route-table.id
}

# Associate route table with private subnets
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.defaut-route-table.id
}