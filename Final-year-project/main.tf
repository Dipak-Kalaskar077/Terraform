provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

resource "aws_instance" "emr_instance" {
  ami           = "ami-04b4f1a9cf54c11d0"  # Your provided AMI ID
  instance_type = "t2.micro"
  key_name      = "vaibhav.key.pem"  # Your provided key name
  security_groups = ["launch-wizard-1"]  # Your provided security group

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y nginx git
    git clone https://github.com/Dipak-Kalaskar077/Final-Year-Project.git /var/www/html
    sudo systemctl restart nginx
  EOF

  tags = {
    Name = "EMR-System-Instance"
  }
}
