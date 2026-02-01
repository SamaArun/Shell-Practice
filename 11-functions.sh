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



# 1️⃣ Shebang
# #!/bin/bash


# 👉 Tells Linux: “Run this script using bash shell.”

# 2️⃣ Check whether user is root
# USERID=$(id -u)


# id -u returns:

# 0 → root user

# non-zero → normal user

# if [ $USERID -ne 0 ]; then


# -ne means not equal

# If user is not root, condition becomes true

#     echo "ERROR:: Please run this script with root access"
#     exit 1


# Prints error

# exit 1 stops the script (failure)

# else
#     echo "You are running with root access"
# fi


# If user is root, script continues

# ✅ This protects system-level commands like dnf install.

# 3️⃣ VALIDATE function (error handling)
# VALIDATE(){
#     if [ $1 -eq 0 ]; then
#         echo "Installing $2 is ... SUCCESS"
#     else
#         echo "Installing $2 is ... FAILURE"
#         exit 1
#     fi
# }

# What this function does

# Takes 2 arguments

# $1 → exit status of last command

# $2 → package name

# How it works

# Exit status 0 → success

# Anything else → failure → script stops

# 📌 This avoids repeating if [ $? -eq 0 ] everywhere.

# 4️⃣ MariaDB installation block
# PACKAGE="mariadb105-server"


# Stores package name in a variable (easy to change later).

# dnf list installed $PACKAGE &>/dev/null


# Checks if package is installed

# Output redirected to /dev/null

# Sets $?

# 0 → installed

# non-zero → not installed

# if [ $? -ne 0 ]; then


# If not installed, go inside if

#     echo "MariaDB is not installed.. going to install it"
#     dnf install $PACKAGE -y
#     VALIDATE $? "mariadb105-server"


# Installs MariaDB

# Calls VALIDATE to confirm success

# else
#     echo "MariaDB is already installed.. nothing to do"
# fi


# If already installed, script skips installation

# ✅ This makes the script idempotent (safe to run multiple times).

# 5️⃣ Python3 installation block

# Same logic as MariaDB, just different package:

# PACKAGE="python3"


# Checks if Python3 is installed

# Installs only if missing

# Validates installation

# VALIDATE $? "python3"

# 6️⃣ Nginx installation block

# Again same logic:

# PACKAGE="nginx"


# Checks for nginx

# Installs if missing

# Validates result