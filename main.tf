resource "aws_vpc" "main" {
  cidr_block       = "172.21.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.21.0.0/21"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public_subnet"
  }
}


resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "gateway_default"
  }
}


resource "aws_route_table" "public-routing-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "gateway_default"
  }
}

resource "aws_route_table_association" "public-route-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-routing-table.id
}
