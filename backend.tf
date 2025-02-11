terraform {
  backend "s3" {
    bucket         = "tsc-terraform-artifacts-test"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}