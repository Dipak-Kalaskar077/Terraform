# provider "aws" {
#   region = "us-east-1"
# }

# resource "aws_instance" "myserver" {
#   ami                    = "ami-0e2c8caa4b6378d8c"
#   key_name               = "vaibhav.key.pem"
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = ["sg-0a7c002efafb49d30"]
#   availability_zone      = "us-east-1b"
#   tags = { 
#     Name        = "dipak-terraform-instance"  # Instance name tag
#     Environment = "dev"
#   }
# }

# resource "aws_vpc" "Dipak_VPC" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name = Dipak_VPC

#   }
# }


# resource "aws_subnet" "public_subnet_cidr" {
#   count = length(var.public_subnet_cidr)
#   vpc_id = aws_vpc.Dipak_VPC.id
#   cidr_block = element(var.public_subnet_cidr, count.index)

#   tags = {
#     Name = "Public Subnet ${count.index + 1}"
#   }
# }

# resource "aws_subnet" "private_subnet_cidr" {
#   count = length(var.private_subnet_cidr)
#   vpc_id = aws_vpc.Dipak_VPC.id
#   cidr_block = element(var.private_subnet_cidr, count.index)

#   tags = {
#     Name = "Private Subnet ${count.index + 1}"
#   } 
  
# }

# resource "aws_internet_gateway" "Dipak_IGW" {
#   vpc_id = aws_vpc.Dipak_VPC.id

#   tags = {
#     Name = "Dipak_IGW"
#   }
# }