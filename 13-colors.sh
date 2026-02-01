#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]; then
    echo -e "$R ERROR:: Please run this script with root access $N"
    exit 1
else
    echo "You are running with root access"
fi
# validate function takes input as exit status, what commad they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]; then
        echo -e "Installing $2 is ... $G SUCCESS $N"
    else
        echo -e "Installing $2 is ... $R FAILURE $N"
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
    echo -e " $Y MariaDB is already installed $N .. nothing to do"
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
    echo -e "nothing to do..$Y Python3 is already installed $N"
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
    echo -e "nothing to do..$Y nginx is already installed $N"
fi