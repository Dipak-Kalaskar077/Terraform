provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myserver" {
  ami                    = "ami-0e2c8caa4b6378d8c"
  key_name               = "vaibhav.key.pem"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Dipak_SG.id]
  tags = { 
    Name        = "dipak-terraform-instance"  # Instance name tag
    Environment = "dev"
  }
}

resource "aws_vpc" "Dipak_VPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Dipak_VPC"
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

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Dipak_IGW.id
  }

  tags = {
    Name = "Dipak_Route_Table"
  }
}

resource "aws_route_table_association" "public_subnet_Association" {
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

  ingress {
    protocol = "tcp"
    from_port = 8080
    to_port = 8080
    cidr_blocks = var.public_subnet_cidr
  }

  tags = {
    Name = "Dipak_SG"
  }
}


# IAM Policies
# To create the resources in this example, you need to attach the following IAM policies to the IAM user or role that you use to run Terraform:

# AmazonEC2FullAccess: Provides full access to Amazon EC2 resources.
# AmazonVPCFullAccess: Provides full access to Amazon VPC resources.
# IAMFullAccess: Provides full access to IAM resources (if you need to create or manage IAM roles and policies).
# AmazonS3FullAccess: Provides full access to Amazon S3 resources (if you need to store Terraform state files in S3).