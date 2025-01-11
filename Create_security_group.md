# Create Security group using terraform

provider "aws" {
   region = "us-east-1"
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