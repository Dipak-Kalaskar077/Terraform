variable "ami_id" {}
#   description = "The AMI ID to use for the instance"
#   type        = string
#   default = "ami-01816d07b1128cd2d"

# }

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default = "vaibhav.key.pem"

}

variable "instance_type" {
  description = "The instance type to use"
  type        = string
  default = "t2.micro"

}

variable "subnet_id" {
  description = "The subnet ID where the instance will be launched"
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

