#!/bin/bash

# Used variables
DB_NAME=""
DB_USER=""
DB_USER_PASS=""
WP_FOLDER=""
INSTALL_PATH="${WP_FOLDER}"

function check_mysql_installed {

    mysql=`which mysql`
    if [ -x $mysql ]; then
        echo "MySQL server installed. OK."
        return 0
    else
        return 1
    fi

}

function check_wordpress_exists {

    # Need to check if existing wordpress is installed on the desired path

    if [ -e $INSTALL_PATH/wp-config.php ]; then
        return 1
    else
        return 0
    fi

}

function check_database_exists {

    # Check if database already exists

    if [ -d /var/lib/mysql/$DB_NAME ]; then
        return 1
    else
        return 0
    fi

}

function get_latest_wordpress {

    # Downlod latest wordpress version to tmp and extract
    mkdir /tmp/wordpress
    wget -O - http://wordpress.org/latest.tar.gz | tar zxf - -C /tmp/wordpress &> /dev/null

    # Create new path for wordpress and copy files to it
    mkdir $INSTALL_PATH &> /dev/null
    mv /tmp/wordpress/wordpress/* $INSTALL_PATH

    # Create wp-config.php file
    cp $INSTALL_PATH/{wp-config-sample.php,wp-config.php}
    chown -R root:root

    # Edit wp-config.php file with mysql data
    sed -i 's/database_name_here/'${DB_NAME}'/' $INSTALL_PATH/wp-config.php
    sed -i 's/username_here/'${DB_USER}'/' $INSTALL_PATH/wp-config.php
    sed -i ' s/password_here/'${DB_USER_PASS}'/' $INSTALL_PATH/wp-config.php

    rm -rf /tmp/wordpress

}


function add_mysqldb_and_user {

    # Form SQL query string
    Q1="CREATE DATABASE IF NOT EXISTS $DB_NAME;"
    Q2="GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'localhost' IDENTIFIED BY '$DB_USER_PASS';"
    Q3="FLUSH PRIVILEGES;"
    SQL="${Q1}${Q2}${Q3}"

    # Execute the query
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "$SQL"

}

function generate_random_pass {

    LENGTH="10"
    MATRIX="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

    while [ "${n:=1}" -le "$LENGTH" ]; do
    	PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"
    	let n+=1
    done

    DB_USER_PASS=$PASS
	
} 

function user_input {

    # Ask database name for Wordpress
    echo ""
    echo "Enter a database name for the wordpress install. E.g domainwp, wordpress, wpdomain"
    DB_NAME=""
    until  [[ "$DB_NAME" =~ [0-9a-zA-Z]+ ]]; do
        echo -n "Database name : "
        read DB_NAME
    done

    # Ask folder name for Wordpress
    echo ""
    echo "Specify a folder name if you wish to install wordpress to its own folder, \"wordpress\" is recommended. Leave blank to install to root directory."

    echo ""
    echo -n "Folder name : "
    read WP_FOLDER


    # Set database user the same as the database name
    DB_USER=$DB_NAME
    # Get full system path for installation
    INSTALL_PATH="${WP_FOLDER}"

}


### Main Program Begins ###

# First generate a random password for the mysql database
generate_random_pass

# Ask user database and folder settings
user_input

echo ""
echo ""
echo "Wordpress setup is ready to begin. Please check to see if the entered details are correct."
echo ""
echo "Install path = $INSTALL_PATH"
echo "Database name = $DB_NAME"
echo "Database user = $DB_USER"
echo "Database Password = $DB_USER_PASS (randomly generated)"
echo ""
echo -n "Is everything correct [y/n] : "

read DECISION

if [[ "$DECISION" = [yY] ]]; then

    check_wordpress_exists
    if [ $? -eq 1 ]; then
       echo "Wordpress already installed in your specified path. Exiting."
       exit
    fi

    check_database_exists
    if [ $? -eq 1 ]; then
       echo "Database \"$DB_NAME\" already exists. Exiting."
       exit
    fi

    check_mysql_installed
    if [ $? -eq 1 ]; then
       echo "MySQL is not installed. Exiting."
       exit
    fi

    echo ""
    echo "Downloading latest version of wordpress..."
    get_latest_wordpress
    echo "Done."

	echo "Setting up MySQL..."
    add_mysqldb_and_user
    echo "Done."
    echo ""

    echo "Wordpress installed successfully!"
    echo "Please browse http://$WP_FOLDER to complete the installation."

elif  [[ "$DECISION" = [nN] ]]; then
    echo "Install aborted. Please run the script again if you want to restart the setup."
fi