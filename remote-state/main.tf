provider "aws" {
  region = "eu-west-3"
}

resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-moqta-state-bucket"
     
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform-state" {
    bucket = aws_s3_bucket.terraform-state.id

    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "lock-state-terraform"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}