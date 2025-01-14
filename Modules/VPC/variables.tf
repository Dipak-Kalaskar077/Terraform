variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "project" {
  description = "The project name"
  type        = string
}

variable "env" {
  description = "The environment (e.g., dev, prod)"
  type        = string
}

variable "pvt_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
}

variable "pub_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
}