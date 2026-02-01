#!/bin/bash

echo "ALL variables passed to the script: $@"
echo "NUmber of variables: $#"
echo "script name: $0"
echo "Current Directory: $PWD"
echo "USer running this script: $USER"
echo "Home directory of user: $HOME"
echo "PID of the script: $$"
sleep 10 &
echo "PID of last commad in backgroud: $!"