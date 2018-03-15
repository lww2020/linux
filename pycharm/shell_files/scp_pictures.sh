#!/bin/bash
# Function: 
# Author: davie
# Date: 2018/3/15
# Version: 1.0
# Script name: scp_pictures.sh
DATE_TIME=`date +%Y_%m_%d_%H_%M_%S`
TARGET_DIR='/Files_www-resources'
if [ ! -d "${TARGET_DIR}" ]; then
    mkdir -p "${TARGET_DIR}"
else
    cd "${TARGET_DIR}"
    tar -czPf Files_www-resources."${DATE_TIME}".tar.gz *
    sleep 180
fi
if [ "$?" -eq 0 ]; then
    # 拷贝远程目录下的文件和目录到本地/Files_www-resources/
    scp  -q -r -l 50000 -C  root@122.10.84.129:/Files_www-resources/*  /Files_www-resources/
fi
chown -R www.www "${TARGET_DIR}"/*
find "${TARGET_DIR}"/* -name "*.gz" -type f -mtime +1 -exec mv /backup/ {} \;
# 删除14天前的压缩文档
find /backup/* -name "*.gz" -type f -mtime +14 -exec rm {} \;
exit 0