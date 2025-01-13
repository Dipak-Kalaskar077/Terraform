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
                        sudo /usr/local/tomcat9/bin/startup.sh

                          EOF
  tags = { 
    Name        = "dipak-terraform-instance"  # Instance name tag
    Environment = "dev"
  }
}