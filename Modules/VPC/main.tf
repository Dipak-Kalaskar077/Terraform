resource "aws_vpc" "mynetwork" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.project
    Env  = var.env
  }
}

resource "aws_subnet" "pvt_subnet" {
  vpc_id = aws_vpc.mynetwork.id
  cidr_block = var.pvt_subnet_cidr
  tags = {
    Name = var.project
    Env  = var.env
  }
}

resource "aws_subnet" "pub_subnet" {
  vpc_id = aws_vpc.mynetwork.id
  cidr_block = var.pub_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = var.project
    Env  = var.env
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.mynetwork.id
  tags = {
    Name = var.project
    Env  = var.env
  }
}

resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.mynetwork.id
  tags = {
    Name = var.project
    Env  = var.env
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table_association" "route_subnet" {
  subnet_id = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.myroute.id
}

resource "aws_security_group" "firewall" {
  vpc_id = aws_vpc.mynetwork.id
  tags = {
    Name = var.project
    Env  = var.env
  }
  ingress = [
    {
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      protocol    = "tcp"
      from_port   = 8080
      to_port     = 8080
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

output "vpc_id" {
  value = aws_vpc.mynetwork.id
}

output "pub_subnet_id" {
  value = aws_subnet.pub_subnet.id
}