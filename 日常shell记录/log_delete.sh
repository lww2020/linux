#!/bin/bash
#######################################################
# Function: Log delete
# Author: davie
# Date: 2018-02-01
# Version: 1.0
# QQ: 178570692

dir_log_1="/home/log/cli_log"
dir_log_2="/home/log/dn"
if  [ -d "${dir_log_1}" ]; then 
        find "${dir_log_1}"/* -name '*.txt' -mtime +14 -exec rm -rf {} \;
fi

sleep 5
if  [ -d "${dir_log_2}" ]; then 
        find "${dir_log_2}"/* -name '*.txt' -mtime +14 -exec rm -rf {} \;
fi
