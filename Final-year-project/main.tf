provider "aws" {
  region = "ap-south-1"  # Change to your desired region
}

resource "aws_instance" "emr_instance" {
  ami           = "ami-00bb6a80f01f03502"  # Your provided AMI ID
  instance_type = "t2.micro"
  key_name      = "Dipak"  # Your provided key name
  security_groups = ["launch-wizard-1"]  # Your provided security group

  user_data = <<-EOF
    #!/bin/bash
    set -e  # Stop script on first error
    sudo apt update -y
    sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql git

    # Start and enable services
    sudo systemctl start apache2
    sudo systemctl enable apache2
    sudo systemctl start mysql
    sudo systemctl enable mysql

    # Clone the project from GitHub
    sudo rm -rf /var/www/html/*
    sudo git clone https://github.com/Dipak-Kalaskar077/Final-Year-Project.git /var/www/html
    sudo chown -R www-data:www-data /var/www/html
    sudo chmod -R 755 /var/www/html

    # Setup MySQL Database and User
    sudo mysql -e "DROP DATABASE IF EXISTS edoc;"
    sudo mysql -e "CREATE DATABASE edoc;"
    sudo mysql -e "DROP USER IF EXISTS 'edoc_user'@'localhost';"
    sudo mysql -e "CREATE USER 'edoc_user'@'localhost' IDENTIFIED BY 'dipak@2424.';"
    sudo mysql -e "GRANT ALL PRIVILEGES ON edoc.* TO 'edoc_user'@'localhost';"
    sudo mysql -e "FLUSH PRIVILEGES;"

    # Import database schema if SQL file exists
    if [ -f /var/www/html/SQL_Database_edoc.sql ]; then
      sudo mysql edoc < /var/www/html/SQL_Database_edoc.sql
    fi

    # Automatically configure connection.php file
    echo "<?php
    \$host = 'localhost';
    \$username = 'edoc_user';
    \$password = 'dipak@2424.';
    \$dbname = 'edoc';

    \$database = new mysqli(\$host, \$username, \$password, \$dbname);

    if (\$database->connect_error) {
        die('Connection failed: ' . \$database->connect_error);
    }
    ?>" | sudo tee /var/www/html/connection.php > /dev/null

    sudo chown www-data:www-data /var/www/html/connection.php
    sudo chmod 644 /var/www/html/connection.php

    # Restart Apache to apply changes
    sudo systemctl restart apache2
  EOF

  tags = {
    Name = "EMR-System-Instance"
  }
}
