#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR:: Please run this script with root access"
    exit 1
else
    echo "You are running with root access"
fi
# validate function takes input as exit status, what commad they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]; then
        echo "Installing $2 is ... SUCCESS"
    else
        echo "Installing $2 is ... FAILURE"
        exit 1
    fi
}

PACKAGE="mariadb105-server"

dnf list installed $PACKAGE &>/dev/null
#check already installed or not, if installed $? is 0, then
#if not installed is not 0 .expression is true
if [ $? -ne 0 ]; then
    echo "MariaDB is not installed.. going to install it"

    dnf install $PACKAGE -y
    VALIDATE $? "mariadb105-server"
    
else
    echo "MariaDB is already installed.. nothing to do"
fi

PACKAGE="python3"

dnf list installed $PACKAGE &>/dev/null
# check already installed or not, if installed $? is 0
# if not installed $? is not 0, expression is true
if [ $? -ne 0 ]; then
    echo "Python3 is not installed.. going to install it"

    dnf install $PACKAGE -y
    VALIDATE $? "python3"
else
    echo "Python3 is already installed.. nothing to do"
fi

PACKAGE="nginx"

dnf list installed $PACKAGE &>/dev/null
# check already installed or not, if installed $? is 0
# if not installed $? is not 0, expression is true
if [ $? -ne 0 ]; then
    echo "Nginx is not installed.. going to install it"

    dnf install $PACKAGE -y
    VALIDATE $? "nginx"
else
    echo "Nginx is already installed.. nothing to do"
fi
