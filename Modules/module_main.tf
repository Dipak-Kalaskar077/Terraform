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

module "aws_instance" {
  source = "./Launch Instance/main.tf"
  ami_id = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  vpc_id = module.myvpc.vpc_id
  subnet_id = module.myvpc.pub_subnet_id
  project = var.project
  env = var.env
}