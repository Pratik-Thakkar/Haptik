#!/bin/bash

sudo apt-get update

# Install CURL
sudo apt-get install curl

# Install Apache
sudo apt-get install apache2
# Y to allow to use disk space
echo "Apache Installed Successfully!"

# Check Firewall Configurations
echo "Your firewall configuration is."
sudo ufw app list
sudo ufw app info "Apache Full"
sudo ufw allow in "Apache Full"
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443

echo "You can check whether the apache is installed properly by accessing public URL/server IP address."
# If you can see the page then Apache installation is successful.

# Install MySQL Server
sudo apt-get install mysql-server
# Y to allow to use disk space
# Enter password for MySQL Root User, Please remeber the password.

sudo mysql_secure_installation
# This asks you if you want to enable secured password for your server.
# Press y|Y, if you want to allow VALIDATE PASSWORD PLUGIN to be used.
# If you select Yes, then it will ask you for password strength
# And to reset password if required (Sample Secure Password : Haksfuh@sfeGa23VhP3)

echo "MySQL Server Installed Successfully!"

# Install PHP
sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql

# Inform Apache to prefer php files over html files
# sudo nano /etc/apache2/mods-enabled/dir.conf
# Move the index.php at first place

# Install PHP Required Extensions
sudo apt-get install php-cli php-mbstring php-gettext php-curl
sudo phpenmod mcrypt
sudo phpenmod mbstring
sudo phpenmod curl
echo "php-cli, curl, mcrypt, mbstring Installed Successfully!"


# Install PHP Dev
sudo apt install php7.0-dev
echo "php7.0-dev Installed Successfully!"

sudo apt-get install php7.0-intl
echo "php7.0-intl Installed Successfully!"

# Restart Apache Server
sudo systemctl restart apache2

echo "Your Home Directory is /var/www/html/. You can start using that Home Directory."


# PHPMyAdmin & Other Extensions
echo "Installing PHPMyAdmin for DB Access & Other Extensions."
sudo apt-get install phpmyadmin
# For the server selection, choose apache2.
# Select yes when asked whether to use dbconfig-common to set up the database
# You will be prompted for your database administrator's password
# You will then be asked to choose and confirm a password for the phpMyAdmin application itself