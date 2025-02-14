variable "public_subnet_cidr" {
  type = list(string)
  description = "Public subnet CIDR Value"
  default = [ "10.0.1.0/24" ]
}

variable "private_subnet_cidr" {
 type = list(string)
 description = "Private subnet CIDR value"
 default = [ "10.0.2.0/24" ] 
}  