terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


# Create an ECR repository
resource "aws_ecr_repository" "repository" {
  name = "my-repository"
}
