variable "aws_region" {
  description = "AWS region"
  type        = string
  default = "us-east-1"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}

# variable "dev_key_pair" {
#   description = "AWS EC2 Key"
#   type        = string
#   sensitive   = true
# }
