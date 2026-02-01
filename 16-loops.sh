#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FLODER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FLODER/$SCRIPT_NAME.log"
PACKAGES=("mariadb105-server" "python3" "nginx" "httpd")

mkdir -p $LOGS_FLODER
echo "Script started executing at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]; then
    echo -e "$R ERROR:: Please run this script with root access $N" | tee -a $LOG_FILE

    exit 1
else
    echo "You are running with root access" | tee -a $LOG_FILE

fi
# validate function takes input as exit status, what commad they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]; then
        echo -e "Installing $2 is ... $G SUCCESS $N" | tee -a $LOG_FILE

    else
        echo -e "Installing $2 is ... $R FAILURE $N" | tee -a $LOG_FILE

        exit 1
    fi
}

for PACKAGE in ${PACKAGES[@]}
do
    dnf list installed $PACKAGE &>>$LOG_FILE
    if [ $? -ne 0 ]; 
    then
        echo "MariaDB is not installed.. going to install it" | tee -a $LOG_FILE
        dnf install $PACKAGE -y &>>$LOG_FILE
        VALIDATE $? "mariadb105-server"
    else
        echo -e "nothing to do.. $Y $PACKAGE is already installed $N" | tee -a $LOG_FILE

    fi
done
