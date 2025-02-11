# associate key from environment
resource "aws_key_pair" "devkey" {
  key_name   = "my_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCafJAWIugLRuXD8NV2rlKNPwbiG5sFtaK0PWQyK10Sl9kjaA+N58TfxL20q57Dhch1nYZQnle6qF7eQruaMaDBFblaHeZhn1lTnSrwFmbRd95vR2CaYIXMUoK8Vwc1ANe+heWjrXTYJXfB2ALyZ6K2Az6Qr91sotckzl7ncx/EH9kwbiRKTkGRtnmydzkEXsQHzAeENgUPgVWYYZhoUM691nKgs3BozCHvnU0rXtCsyDDaw+MlN7qJ/vf6S31YXcgxoZQXqJwh/0KzsLUCOI3Vq1K0sVa+l+Av0z/OKnBI+Vm5tLUvziLsXmIkmguRvTIU2G9tIQVhzg1QgpywVFZH ayon.choudhury@C02G869CMD6M"
}

# Locust Master EC2 Instance
resource "aws_instance" "tsc_poc_locust_master" {
  ami             = "ami-000947bc9f68a49fe"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.tsc_poc_public_subnet1.id
  security_groups = [aws_security_group.tsc_poc_ec2_locust_sg.id]
  key_name        = aws_key_pair.devkey.key_name
  
  # Attach Iam roles
  iam_instance_profile = aws_iam_instance_profile.ec2_locust_s3_profile.name

  # user_data = <<-EOF
  #             #!/bin/bash
  #             sudo yum update -y
  #             sudo yum install -y aws-cli python3 python3-pip git
  #             pip3 install locust

  #             # Start Locust Master
  #             # locust -f /home/ec2-user/locustfile.py --master --host=http://your-app-url &
  #             EOF

  tags = {
    Name       = "locust-master"
    nukeoptout = "true"
  }
  depends_on = [aws_key_pair.devkey]
}

# Locust Worker EC2 Instance
resource "aws_instance" "tsc_poc_locust_worker" {
  ami             = "ami-000947bc9f68a49fe"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.tsc_poc_public_subnet1.id
  security_groups = [aws_security_group.tsc_poc_ec2_locust_sg.id]
  key_name        = aws_key_pair.devkey.key_name
  
  # Attach Iam Role
  iam_instance_profile = aws_iam_instance_profile.ec2_locust_s3_profile.name

  # user_data = <<-EOF
  #             #!/bin/bash
  #             sudo yum update -y
  #             sudo yum install -y aws-cli python3 python3-pip git
  #             pip3 install locust

  #             # Start Locust Worker (Replace MASTER_IP dynamically)
  #             # locust -f /home/ec2-user/locustfile.py --worker --master-host=${aws_instance.tsc_poc_locust_master.private_ip} &
  #             EOF

  tags = {
    Name       = "locust-worker"
    nukeoptout = "true"
  }
  depends_on = [aws_key_pair.devkey]
}
