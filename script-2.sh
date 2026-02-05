#!/bin/bash

echo "PID of SCRIPT-2: $$"
echo "$GREETING"



# write a seperate file, create functions with all common code, call when required...

# How can you call other scripts from current script

# script-1.sh
# script-2.sh

# how you call script-2 from script-1

# ./script-2.sh
# =========================
# can't access scritp-1 variables
# PID are different

# source ./script-2.sh
# =========================
# same PID for both scripts
# SCRIPT-2 can acess SCRIPT-1 variables
# SCRIPT-1 can access SCRIPT-2 variables