resource "aws_security_group" "tsc_poc_lb_sg" {
  vpc_id = aws_vpc.tsc_poc_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "tsc-poc-load-balancer-sg"
    nukeoptout = "true"
  }
}

# Security Group for Locust communication
resource "aws_security_group" "tsc_poc_ec2_locust_sg" {
  vpc_id = aws_vpc.tsc_poc_vpc.id

  # Allow SSH for admin access (optional)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Locust web UI and API (8089)
  ingress {
    from_port   = 8089
    to_port     = 8089
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "locust-sg"
    nukeoptout = "true"
  }
}

resource "aws_security_group_rule" "locust_internal" {
  type                     = "ingress"
  from_port                = 8089
  to_port                  = 8089
  protocol                 = "tcp"
  security_group_id        = aws_security_group.tsc_poc_ec2_locust_sg.id
  source_security_group_id = aws_security_group.tsc_poc_ec2_locust_sg.id # Self-reference fix
}
