terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
 
# Create the security group and specify the allowed ports
resource "aws_security_group" "sg" {
  name        = "my-security-group"
   vpc_id = var.vpc_id
  description = "Security group for my resources"

# Generate the ingress rules using the dynamic block
  dynamic "ingress" {
    for_each = local.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}