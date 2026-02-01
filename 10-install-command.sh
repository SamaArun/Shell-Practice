#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run this script with root access"
    exit 1 #give other than 0 upto 127
else
    echo "You are running with root access"
fi

dnf list installed mariadb

if [ $? -ne 0 ]
then
    echo "MySQL is not installed.. going to install it"
    dnf install mariadb105-server -y

    if [ $? -eq 0 ]
    then
        echo " Installing MySQL is ..SUCCESS"
    else
        echo "Install MYSQL is ... FAILURE"
        exit 1
    fi
else
    echo "MySQL is already installed.. nothing to do"
   
fi

# dnf install mariadb105-server -y

# if [ $? -eq 0 ]
# then
#     echo " Installing MySQL is ..SUCCESS"
# else
#     echo "Install MYSQL is ... FAILURE"
#     exit 1
# fi