# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "tsc-terraform-artifacts"

#   tags = {
#     Name        = "TerraformStateBucket"
#     Environment = "Dev"
#   }
# }

# resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
#   bucket = aws_s3_bucket.terraform_state.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
#   bucket = aws_s3_bucket.terraform_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# resource "aws_s3_bucket_public_access_block" "terraform_state_block" {
#   bucket = aws_s3_bucket.terraform_state.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket" "locust_reports" {
#   bucket = "tsc-locust-reports"

#   tags = {
#     Name        = "LocustReports"
#     Environment = "Production"
#   }
# }

# resource "aws_s3_bucket_versioning" "locust_reports_versioning" {
#   bucket = aws_s3_bucket.locust_reports.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "locust_reports_encryption" {
#   bucket = aws_s3_bucket.locust_reports.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# resource "aws_s3_bucket_public_access_block" "locust_reports_block" {
#   bucket = aws_s3_bucket.locust_reports.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }