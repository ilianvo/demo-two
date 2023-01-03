terraform {
  backend "s3" {
    bucket         = "terraform-moqta-state-bucket"
    key            = "./terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "lock-state-terraform"
  }
}
