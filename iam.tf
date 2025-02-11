# IAM Policy to allow S3 access to EC2
resource "aws_iam_role" "ec2_locust_s3_role" {
  name = "EC2-Locust-S3-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy to allow EC2 access to S3
resource "aws_iam_policy" "ec2_s3_policy" {
  name        = "EC2-Locust-S3-Policy"
  description = "Policy to allow EC2 instances to access specific S3 bucket"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::your-locust-reports-bucket",
          "arn:aws:s3:::your-locust-reports-bucket/*"
        ]
      }
    ]
  })
}

# Attach the policy to the IAM role
resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  policy_arn = aws_iam_policy.ec2_s3_policy.arn
  role       = aws_iam_role.ec2_locust_s3_role.name
}

# Create IAM Instance Profile for EC2
resource "aws_iam_instance_profile" "ec2_locust_s3_profile" {
  name = "EC2-Locust-S3-Profile"
  role = aws_iam_role.ec2_locust_s3_role.name
}
