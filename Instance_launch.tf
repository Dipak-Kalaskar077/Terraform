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