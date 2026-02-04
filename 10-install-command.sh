#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR:: Please run this script with root access"
    exit 1
else
    echo "You are running with root access"
fi

PACKAGE="mariadb105-server"

dnf list installed $PACKAGE &>/dev/null
#check already installed or not, if installed $? is 0, then
#if not installed is not 0 .expression is true
if [ $? -ne 0 ]; then
    echo "MariaDB is not installed.. going to install it"

    dnf install $PACKAGE -y

    if [ $? -eq 0 ]; then
        echo "Installing MariaDB is ... SUCCESS"
        systemctl enable mariadb
        systemctl start mariadb
    else
        echo "Installing MariaDB is ... FAILURE"
        exit 1
    fi
else
    echo "MariaDB is already installed.. nothing to do"
fi


# dnf install mariadb105-server -y

# if [ $? -eq 0 ]
# then
#     echo " Installing MySQL is ..SUCCESS"
# else
#     echo "Install MYSQL is ... FAILURE"
#     exit 1
# fi