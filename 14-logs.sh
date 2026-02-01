#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FLODER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FLODER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FLODER
echo "Script started executing at: $(date)" &>>$LOG_FILE

if [ $USERID -ne 0 ]; then
    echo -e "$R ERROR:: Please run this script with root access $N" &>>$LOG_FILE

    exit 1
else
    echo "You are running with root access" &>>$LOG_FILE

fi
# validate function takes input as exit status, what commad they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]; then
        echo -e "Installing $2 is ... $G SUCCESS $N" &>>$LOG_FILE

    else
        echo -e "Installing $2 is ... $R FAILURE $N" &>>$LOG_FILE

        exit 1
    fi
}

PACKAGE="mariadb105-server"

dnf list installed $PACKAGE &>>$LOG_FILE

#check already installed or not, if installed $? is 0, then
#if not installed is not 0 .expression is true
if [ $? -ne 0 ]; then
    echo "MariaDB is not installed.. going to install it" &>>$LOG_FILE


    dnf install $PACKAGE -y &>>$LOG_FILE

    VALIDATE $? "mariadb105-server"
    
else
    echo -e " $Y MariaDB is already installed $N .. nothing to do" &>>$LOG_FILE

fi

PACKAGE="python3"

dnf list installed $PACKAGE &>>$LOG_FILE

# check already installed or not, if installed $? is 0
# if not installed $? is not 0, expression is true
if [ $? -ne 0 ]; then
    echo "Python3 is not installed.. going to install it" &>>$LOG_FILE


    dnf install $PACKAGE -y &>>$LOG_FILE

    VALIDATE $? "python3"
else
    echo -e "nothing to do..$Y Python3 is already installed $N" &>>$LOG_FILE

fi

PACKAGE="nginx"

dnf list installed $PACKAGE &>>$LOG_FILE

# check already installed or not, if installed $? is 0
# if not installed $? is not 0, expression is true
if [ $? -ne 0 ]; then
    echo "Nginx is not installed.. going to install it" &>>$LOG_FILE


    dnf install $PACKAGE -y &>>$LOG_FILE

    VALIDATE $? "nginx"
else
    echo -e "nothing to do..$Y nginx is already installed $N" &>>$LOG_FILE

fi