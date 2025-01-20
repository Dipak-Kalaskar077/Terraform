provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "emr_instance" {
  ami           = "ami-04b4f1a9cf54c11d0"  # Your provided AMI ID
  instance_type = "t2.micro"
  key_name      = "vaibhav.key.pem"  # Your provided key name
  security_groups = ["launch-wizard-1"]  # Your provided security group

  user_data = <<-EOF
    #!/bin/bash
    set -e  # Exit script on error

    # Update package lists
    sudo apt update -y

    # Install Apache, PHP, and required dependencies
    sudo apt install -y apache2 php libapache2-mod-php php-mysql git mysql-server

    # Start and enable Apache & MySQL
    sudo systemctl start apache2
    sudo systemctl enable apache2
    sudo systemctl start mysql
    sudo systemctl enable mysql

    # Clone the project from GitHub
    cd /var/www/html
    sudo git clone https://github.com/Dipak-Kalaskar077/Final-Year-Project.git .
    sudo chown -R www-data:www-data /var/www/html
    sudo chmod -R 755 /var/www/html

    # Configure MySQL database
    sudo mysql -u root <<MYSQL_SCRIPT
    CREATE DATABASE IF NOT EXISTS edoc;
    CREATE USER IF NOT EXISTS 'edoc_user'@'localhost' IDENTIFIED BY 'dipak@2424.';
    GRANT ALL PRIVILEGES ON edoc.* TO 'edoc_user'@'localhost';
    FLUSH PRIVILEGES;
    USE edoc;
    SOURCE /var/www/html/SQL_Database_edoc.sql;
    MYSQL_SCRIPT

    # Restart Apache to apply changes
    sudo systemctl restart apache2
  EOF

  tags = {
    Name = "EMR-System-Instance"
  }
}
