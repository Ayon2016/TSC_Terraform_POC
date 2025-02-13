terraform {
  backend "s3" {
    bucket         = "tsc-terraform-artifact"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}