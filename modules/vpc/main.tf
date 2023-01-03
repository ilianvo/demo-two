terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr
  
  tags = {
    Name = "my_vpc"
  }
 
}