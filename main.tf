provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myserver" {
  ami                    = "ami-0e2c8caa4b6378d8c"
  key_name               = "vaibhav.key.pem"
  instance_type          = "t2.micro"
  vpc_security_group_ids = aws_security_group.Dipak_SG.id
  availability_zone      = "us-east-1b"
  tags = { 
    Name        = "dipak-terraform-instance"  # Instance name tag
    Environment = "dev"
  }
}

resource "aws_vpc" "Dipak_VPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = Dipak_VPC

  }
}


resource "aws_subnet" "public_subnet_cidr" {
  count = length(var.public_subnet_cidr)
  vpc_id = aws_vpc.Dipak_VPC.id
  cidr_block = element(var.public_subnet_cidr, count.index)

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet_cidr" {
  count = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.Dipak_VPC.id
  cidr_block = element(var.private_subnet_cidr, count.index)

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  } 
  
}

resource "aws_internet_gateway" "Dipak_IGW" {
  vpc_id = aws_vpc.Dipak_VPC.id

  tags = {
    Name = "Dipak_IGW"
  }
}

resource "aws_route_table" "Dipak_Route_Table" {
  vpc_id = aws_vpc.Dipak_VPC.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Dipak_IGW.id
  }

  tags = {
    Name = Dipak_Route_Table
  }
}

resource "aws_route_table_association" "Public_subnet_Association" {
  count = length(var.public_subnet_cidr)
  subnet_id = element(aws_subnet.public_subnet_cidr[*].id, count.index)
  route_table_id = aws_route_table.Dipak_Route_Table.id
}

resource "aws_route_table_association" "Private_subnet_Association" {
  count = length(var.private_subnet_cidr)
  subnet_id = element(aws_subnet.private_subnet_cidr[*].id, count.index)
  route_table_id = aws_route_table.Dipak_Route_Table.id
}

resource "aws_security_group" "Dipak_SG" {
  vpc_id = aws_vpc.Dipak_VPC.id
  ingress = {
    protocol = "Custom TCP"
    form_port = 8080
    to_port = 8080
    cidr = var.Dipak_SG.public_subnet_cidr
  }

  tags = {
    Name = "Dipak_SG"
  }
}