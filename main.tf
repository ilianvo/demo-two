terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


# Configure the AWS Provider
#provider "aws" {
  #region = var.region
#}


module "vpc" {
  source = "./modules/vpc"
  
}

module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
  
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  subnet_id = module.subnet.subnet_id
  security_group_id = module.sg.security_group_id
}

module "ecr" {
  source = "./modules/ecr"
  
}