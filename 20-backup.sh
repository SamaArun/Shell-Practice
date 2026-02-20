#!/bin/bash

USERID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if DAYS are provided that will be considered, otherwise default 14 days

LOGS_FLODER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FLODER/$SCRIPT_NAME.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# validate function takes input as exit status, what commad they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]; 
    then
        echo -e "$2 is ... $G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is ... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi
}

check_root(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$R ERROR:: Please run this script with root access $N"
        exit 1 #give other than 0 upto 127
    else
        echo "You are running with root access"
    fi
}

check_root
mkdir -p $LOGS_FLODER

USAGE(){
    echo -e "$R USAGE:: $N sh 20-backup.sh <source-directory>  <destination_directory> <days(optional)>"
}

if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]
then
    echo -e "$R Source Directory $SOURCE_DIR does not exist. Please check $N"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo -e "$R Destination Directory $DEST_DIR does not exist. Please check $N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ ! -z "$FILES" ] 
then
    echo "Files to zip are: $FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE=$DEST_DIR/app-logs-$TIMESTAMP.zip
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ $ZIP_FILE 

    if [ -f $ZIP_FILE ]
    then 
        echo -e "Successfully cerated Zip file"

        while IFS= read -r filepath
        do
            echo "Deleting file: $filepath" | tee -a $LOG_FILE
            rm -rf $filepath
        done <<< $FILES

        echo -e "Log files older than $DAYS from source directory removed....$G SUCESS $N"
    else
        echo -e "Zip file creation... $R FAILURE $N"
        exit 1
    fi
else
    echo -e "No log files found older than 14 days ... $Y SKIPPING $N"
fi
#install ZIP commads if not there

#sudo sh 20-backup.sh /home/ec2-user/source-dir/ /home/ec2-user/dest-dir/ we need to run with full path
#corn -e

#sudo tail -f /var/log/cron
# for cron job


# find <source_directory> -name "*.log" -mtime +14

# source_directory
# find the files
# delete the files

# 14 days old  log files can be zipped and placed into destination directory...storage team usually monitors the destination directory if they find any files there they move to another server

# source_directory
# destination_directory

# need to check source_directory directory exist or not
# destination directory also should be checked

# find the files
# zip the files
# move to destination directory
# then remove the files in source_directory

# sh backup.sh <source-directory>  <destination_directory> <days>

# app-logs-$TIMESTAMP.zip

# crontab --> scheduling the scripts in linux --> usually non business hours at 3 or 4AM

# * * * * * sudo sh /home/ec2-user/shell-practice/20-backup.sh /home/ec2-user/source-dir /home/ec2-user/dest-dir
#* * * * * sudo backup /home/ec2-user/source-dir  /home/ec2-user/dest_dir #after command

#for making command: sudo cp 20-backup.sh /usr/local/bin/backup
#sudo chmod +x /usr/local/bin/backup

#work with sudo #sudo backup

#/usr/local/bin/ we need to add in #sudo visudo #secure_path add /local

# Crontab
# ========
# /usr/bin:/bin
#recently I was given a script to create backup of the files, I successfully created the script and shceduled in crontab, but command not found in crontab. When I executed it is working fine manually. Later I understood PATH is bare minimum in crontab so I changed my script as command into /usr/bin directory. It started working fine..

#10 change $SCRIPT_NAME to backup

#df -hT 
#df -hT | awk '{print $6F}'
#df -hT | grep -v Filesystem | awk '{print $6F}'#cuts the line 

#df -hT | grep -v Filesystem | awk '{print $6F}' | cut -d "%" -f1

#df -hT | grep -v Filesystem | awk '{print $7F}'

# 2️⃣ Check disk usage
# df -hT

# Sample output (as seen)
# Filesystem                      Type   Size  Used Avail Use% Mounted on
# devtmpfs                        devtmpfs 4.0M     0  4.0M   0% /dev
# tmpfs                           tmpfs   355M     0  355M   0% /dev/shm
# tmpfs                           tmpfs   142M   2.3M 140M   2% /run
# /dev/mapper/RootVG-rootVol      xfs     6.8G   1.8G 4.2G  30% /
# /dev/mapper/RootVG-varVol       xfs     2.0G   418M 1.6G  22% /var
# /dev/mapper/RootVG-varTmpVol    xfs     2.0G    47M 1.9G   3% /var/tmp
# /dev/mapper/RootVG-homeVol      xfs     960M    40M 921M   5% /home
# /dev/mapper/RootVG-logVol       xfs     2.0G    66M 1.9G   4% /var/log
# /dev/nvme0n1p3                  xfs     424M   223M 202M  53% /boot
# /dev/nvme0n1p2                  vfat    122M   7.0M 115M   6% /boot/efi
# /dev/mapper/RootVG-auditVol     xfs     4.4G    64M 4.3G   2% /var/log/audit
# tmpfs                           tmpfs    71M     0   71M   0% /run/user/1001



# 4️⃣ Correct awk command
# df -hT | awk '{print $6}'

# Output shown
# Use%
# 0%
# 0%
# 2%
# 30%
# 22%
# 3%
# 5%
# 4%
# 53%
# 6%
# 2%
# 0%