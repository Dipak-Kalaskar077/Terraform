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
    sudo apt install apache2 -y
    sudo systemctl start apache2
    sudo systemctl enable apache2
    sudo apt install mysql-server -y
    sudo systemctl start mysql
    sudo systemctl enable mysql

    sudo apt install php libapache2-mod-php php-mysql
    sudo systemctl restart apache2


    # Clone the project from GitHub
    cd /var/www/html
    sudo rm -rvf index.html
    sudo git clone https://github.com/Dipak-Kalaskar077/Final-Year-Project.git .
    sudo chown -R www-data:www-data /var/www/html
    sudo chmod -R 755 /var/www/html

    # Setup MySQL Database
    sudo mysql -e "CREATE DATABASE edoc;"
    sudo mysql -e "CREATE USER 'edoc_user'@'localhost' IDENTIFIED BY 'dipak@2424.';"
    sudo mysql -e "GRANT ALL PRIVILEGES ON edoc.* TO 'edoc_user'@'localhost';"
    sudo mysql -e "FLUSH PRIVILEGES;"

    # Import database schema (Assuming there's an SQL file in the project repository)
    sudo mysql edoc < /var/www/html/database/edoc.sql

    # Restart Apache
    sudo systemctl restart apache2
  EOF

  tags = {
    Name = "EMR-System-Instance"
  }
}

