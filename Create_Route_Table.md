# Create Route Table using terraform

provider "aws" {
   region = "us-east-1"
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