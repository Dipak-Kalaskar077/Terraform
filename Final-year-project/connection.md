<?php
$host = 'localhost'; // Database server (localhost for local MySQL server)
$username = 'your_database_username'; // Your MySQL username
$password = 'your_database_password'; // Your MySQL password
$dbname = 'edoc'; // The database name you want to use

// Create connection
$conn = new mysqli($host, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>


sudo apt update
sudo apt install mysql-server
sudo systemctl start mysql



sudo mysql -u root -p



CREATE DATABASE edoc;
USE edoc;
SOURCE /var/www/html/SQL_Database_edoc.sql;

## To check the error for why login page is not loading use this command

sudo cat /var/log/apache2/error.log


## use this file for error handling at connection.php

<?php
$host = 'localhost'; // Database server
$username = 'edoc_user'; // Your MySQL username
$password = 'dipak@2424.'; // Your MySQL password
$dbname = 'edoc'; // Database name

// Create connection
$database = new mysqli($host, $username, $password, $dbname);

// Check connection
if ($database->connect_error) {
    die("Connection failed: " . $database->connect_error);
}
?>



## Check this 

sudo mysql -u root -p

SELECT user, host FROM mysql.user;

(Enter your MySQL root password when prompted)
Then, check if edoc_user exists and has the correct privileges:

SELECT user, host FROM mysql.user;

If edoc_user is missing, create it again:

CREATE USER 'edoc_user'@'localhost' IDENTIFIED BY 'dipak@2424.';
GRANT ALL PRIVILEGES ON edoc.* TO 'edoc_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;


##  Restart MySQL and Apache

sudo systemctl restart mysql
sudo systemctl restart apache2

