# provider "aws" {
#   region = "us-east-1"  # Change to your desired region
# }

# resource "aws_instance" "emr_instance" {
#   ami           = "ami-04b4f1a9cf54c11d0"  # Your provided AMI ID
#   instance_type = "t2.micro"
#   key_name      = "vaibhav.key.pem"  # Your provided key name
#   security_groups = ["launch-wizard-1"]  # Your provided security group

#   user_data = <<-EOF
#     #!/bin/bash
#     sudo apt update -y
#     sudo apt install -y nginx git
#     sudo rm /var/www/html/index.nginx-debian.html
#     cd /var/www/html
#     sudo git clone https://github.com/Dipak-Kalaskar077/Final-Year-Project.git .
#     sudo chown -R www-data:www-data /var/www/html
#     sudo chmod -R 755 /var/www/html
#     sudo systemctl restart nginx

#     sudo apt update
#     sudo apt install mysql-server
#     sudo systemctl start mysql
#     sudo mysql_secure_installation


# sudo apt install apache2 -y
# sudo systemctl start apache2
# sudo systemctl enable apache2


# sudo apt install php libapache2-mod-php php-mysql -y
# sudo systemctl restart apache2
# sudo mv /home/ubuntu/edoc-echanneling-main /var/www/html/edoc-echanneling-main
# sudo chown -R www-data:www-data /var/www/html/edoc-echanneling-main
# sudo chmod -R 755 /var/www/html/edoc-echanneling-main



# sudo mysql -u root -p
# CREATE DATABASE edoc;
# CREATE USER 'edoc_user'@'localhost' IDENTIFIED BY 'dipak@2424.';
# GRANT ALL PRIVILEGES ON edoc.* TO 'edoc_user'@'localhost';
# EXIT;


# cd /var/www/html/edoc-echanneling-main
# <?php
# $servername = "localhost";  // MySQL is on the same server
# $username = "edoc_user";  // The MySQL user you created
# $password = "your_password";  // The password you set
# $dbname = "edoc";  // The database name you created
# ?>


# sudo systemctl restart apache2


#   EOF

#   tags = {
#     Name = "EMR-System-Instance"
#   }
# }
