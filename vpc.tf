resource "aws_vpc" "tsc_poc_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name       = "tsc_poc_vpc"
    nukeoptout = "true"
  }
}

resource "aws_subnet" "tsc_poc_public_subnet1" {
  vpc_id                  = aws_vpc.tsc_poc_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name       = "public-subnet-az1"
    nukeoptout = "true"
  }
}

resource "aws_subnet" "tsc_poc_public_subnet2" {
  vpc_id                  = aws_vpc.tsc_poc_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name       = "public-subnet-az2"
    nukeoptout = "true"
  }
}

resource "aws_internet_gateway" "tsc_poc_igw" {
  vpc_id = aws_vpc.tsc_poc_vpc.id

  tags = {
    Name       = "internet-gateway"
    nukeoptout = "true"
  }
}

# Create a Route Table for Public Subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.tsc_poc_vpc.id

  route {
    cidr_block = "0.0.0.0/0" # Route all internet traffic
    gateway_id = aws_internet_gateway.tsc_poc_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate Route Table with the First Public Subnet
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.tsc_poc_public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate Route Table with the Second Public Subnet
resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.tsc_poc_public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

