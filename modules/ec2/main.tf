terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

data "aws_ami" "ubuntu" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "EC2" {
  count = length(var.subnet_id)
  ami = data.aws_ami.ubuntu.id
  instance_type = var.type_instance
  subnet_id = var.subnet_id[count.index]
  vpc_security_group_ids = var.security_group_id.*.id
  tags = {
  Name = "ec2-${count.index + 1}"
  }
  }