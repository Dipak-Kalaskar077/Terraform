# Terraform Installation and Commands

Terraform is an open-source software tool that helps users configure and manage infrastructure as code (IaC)

*** Install Terraform on Linux/ubuntu Using Package Repository ***

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt install terraform

terraform --version

*** Attach Role to Instance ***

create Role for terraform

Role :- policy > EC2 Full access

*** Clone The Repo which have Terraform file ***

#This is code for launching the instance 
#create a repo and store this code to github

provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "myserver" {
    ami = "ami-0e2c8caa4b6378d8c"
    key_name = "vaibhav.key.pem" 
    instance_type = "t2.micro"
    vpc_security_group_ids = [ "sg-0a7c002efafb49d30" ]
    availability_zone = "us-east-1b"
    tags = {
      name = "dipak"
      env = "dev"
    }
}

git clone "REPO_URL"

*** Now init the Terraform file ***

command :- terraform init

*** Now Plan for Terraform ***

In this step The terraform scan the project and install all the dependices required for the project

command :- terraform plan

*** To Apply all changes and create/execution of file to create ec2 instance ***

command :- terraform apply

here your file is executed and New instance is created 

*** To Destroy or Terminate the Instance created by Terraform use ***

Command :- terraform destroy
