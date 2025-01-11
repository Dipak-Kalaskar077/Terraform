# provider "aws" {
#   region = "us-east-1"
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