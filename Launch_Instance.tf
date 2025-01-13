provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myserver" {
  ami                    = "ami-0e2c8caa4b6378d8c"
  key_name               = "vaibhav.key.pem"
  instance_type          = "t2.micro"
  

  ## User data to install Java and Tomcat
  user_data              = <<-EOF
                          #!/bin/bash
                          sudo yum update -y
                          sudo yum install -y java-1.8.0-openjdk
                          sudo yum install -y wget
                          wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz
                          tar -xzf apache-tomcat-9.0.41.tar.gz
                          sudo mv apache-tomcat-9.0.41 /usr/local/tomcat9
                          sudo chmod +x /usr/local/tomcat9/bin/*.sh
                          sudo /usr/local/tomcat9/bin/startup.sh
                          EOF
  tags = { 
    Name        = "dipak-terraform-instance"  # Instance name tag
    Environment = "dev"
  }
}