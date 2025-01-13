provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myserver" {
  ami                    = "ami-0e2c8caa4b6378d8c"  # Ubuntu AMI ID
  key_name               = "vaibhav.key.pem"
  instance_type          = "t2.micro"

  # Automatically assign a public IP
  associate_public_ip_address = true

  # Security group to allow SSH and HTTP
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  ## User data to install Java and Tomcat
  user_data = <<-EOF
              #!/bin/bash
              # Update package lists and upgrade installed packages
              sudo apt update -y
              sudo apt upgrade -y

              # Install Java 8 and wget
              sudo apt install -y openjdk-8-jdk wget

              # Download and extract Tomcat
              wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz
              tar -xzf apache-tomcat-9.0.41.tar.gz

              # Move Tomcat to /usr/local and set permissions
              sudo mv apache-tomcat-9.0.41 /usr/local/tomcat9
              sudo chmod +x /usr/local/tomcat9/bin/*.sh

              # Start Tomcat server
              sudo /usr/local/tomcat9/bin/startup.sh > /var/log/tomcat-startup.log 2>&1 &
              EOF

  tags = { 
    Name        = "dipak-terraform-instance"  # Instance name tag
    Environment = "dev"
  }
}

resource "aws_security_group" "my_sg" {
  name_prefix = "dipak-sg-"
  description = "Allow SSH and HTTP access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    protocol   = "tcp"
    from_port  = 22
    to_port    = 22
    cidr_blocks = ["0.0.0.0/0"]  # SSH access
  }

  ingress {
    protocol   = "tcp"
    from_port  = 8080
    to_port    = 8080
    cidr_blocks = ["0.0.0.0/0"]  # Tomcat access
  }

  egress {
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "Dipak_SG"
  }
}
