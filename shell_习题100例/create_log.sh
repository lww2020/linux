#!/bin/bash
:<<block
例题一：
【题目要求】
请按照这样的日期格式(xxxx-xx-xx)每日生成一个文件，例如今天生成的文件为2017-12-20.log，
并且把磁盘的使用情况写到这个文件中。(不用考虑crontab，仅仅写脚本即可)
block

date_time=`date +%Y-%m-%d`
create_log="/bin/df -Th"
if [ ! -f /home/log ]; then
	mkdir -p /home/log
	chmod 777 /home/log
fi
$create_log >> /home/log/"${date_time}".log
