variable "vpc_id" {}


variable "private_subnet_cidr" {
  description = "Declare a variable to store the list of IP addresses for private subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_cidr" {
  description = "Declare a variable to store the list of IP addresses for public subnets"
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}