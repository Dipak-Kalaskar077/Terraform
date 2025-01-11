# Create VPC using Terraform

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "Dipak_VPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Dipak_VPC"
  }
} 