variable "aws_region" {
  default = "us-east-1"
}
variable "ami_id" {
  default = "ami-01816d07b1128cd2d"
}
variable "key_name" {
  default = "vaibhav.key.pem"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "project" {
  default = "moon_wars"
}
variable "env" {
  default = "avengers"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "pvt_subnet_cidr" {
  default = "10.0.1.0/20"
}
variable "pub_subnet_cidr" {
  default = "10.0.2.0/20"
}
variable "ami_id" {
  default = "ami-01816d07b1128cd2d"
  
}