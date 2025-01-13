provider "aws" {
  region = "us-east-1"  # Choose your region
}

resource "aws_instance" "default_vpc_instance" {
  ami                    = "ami-0e2c8caa4b6378d8c"  # Replace with a valid AMI ID for your region
  instance_type          = "t2.micro"
  key_name               = "vaibhav.key.pem"        # Replace with your key pair name
  associate_public_ip_address = true               # Ensures public IP is assigned

  # User data script for installing Java and Tomcat
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt upgrade -y
              sudo apt install -y openjdk-8-jdk wget
              wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz
              tar -xzf apache-tomcat-9.0.41.tar.gz
              sudo mv apache-tomcat-9.0.41 /usr/local/tomcat9
              sudo chmod +x /usr/local/tomcat9/bin/*.sh
              sudo /usr/local/tomcat9/bin/startup.sh > /var/log/tomcat-startup.log 2>&1 &
              EOF

  # Use the default security group
  vpc_security_group_ids = [aws_security_group.default_sg.id]

  tags = {
    Name = "default-vpc-instance"
  }
}

resource "aws_security_group" "default_sg" {
  name_prefix = "default-sg-"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP (Tomcat) from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "default-vpc-sg"
  }
}

data "aws_vpc" "default" {
  default = true
}
