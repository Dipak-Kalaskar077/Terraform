output "vpc_id" {
  value = module.myvpc.vpc_id
}

output "instance_public_ip" {
  value = module.aws_instance.public_ip
}
