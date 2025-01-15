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
  source = "./Instance/main.tf"
  ami_id = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
 
  subnet_id = module.myvpc.pub_subnet_id
  project = var.project
  env = var.env
}
