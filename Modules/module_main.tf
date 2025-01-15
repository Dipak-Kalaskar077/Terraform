provider "aws" {
  region = var.aws_region
}

module "myvpc" {
  source = "./VPC"
  vpc_cidr = var.vpc_cidr
  pvt_subnet_cidr = var.pvt_subnet_cidr
  pub_subnet_cidr = var.pub_subnet_cidr
  project = var.project
  env = var.env
}

module "Instance" {
  source = "./Instance"
  ami = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  vpc_id = module.myvpc.vpc_id
  subnet_id = module.myvpc.pub_subnet_id
  project = var.project
  env = var.env
}

output "vpc_id" {
  value = module.myvpc.vpc_id
}

output "instance_public_ip" {
  value = module.aws_instance.public_ip
}
