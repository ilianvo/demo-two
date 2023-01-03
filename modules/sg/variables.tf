variable "vpc_id" {}


locals {
  allowed_ports = [22, 80, 443]
}