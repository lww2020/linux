#!/bin/bash

c1=`grep -w 'bkuser' /etc/passwd | wc -l`
if [ "$c1" -eq 1 ]; then 
	echo "bkuser已经存在"
	c2=`grep -w 'bkuser' /etc/sudoers | wc -l`
	if [ "$c2" -ge 1 ]; then 
		echo "bkuser sudo成功."
		exit
	else
		echo "bkuser sudo失败"
		cp /etc/sudoers /etc/sudoers.bak.`date +%Y_%m_%d_%S` >/dev/null
		echo "bkuser   ALL=(ALL)       NOPASSWD: ALL" >>/etc/sudoers
		sleep 1
	    echo "bkuser sudo已成功添加"
	fi
else
	echo "bkuser不存在"
	useradd bkuser
	echo "bkuser@123" | passwd --stdin bkuser >/dev/null
	cp /etc/sudoers /etc/sudoers.bak.`date +%Y_%m_%d_%S`
	echo "bkuser   ALL=(ALL)       NOPASSWD: ALL" >>/etc/sudoers
	echo "bkuser已经成功添加，且加入sudo"
	sleep 2
	c2=`grep -w 'bkuser' /etc/sudoers | wc -l`
	if [ "$c2" -ge 1 ]; then 
		echo "bkuser sudo成功."
		exit
	else
		echo "bkuser sudo失败"
		cp /etc/sudoers /etc/sudoers.bak.`date +%Y_%m_%d_%S` >/dev/null
		echo "bkuser   ALL=(ALL)       NOPASSWD: ALL" >>/etc/sudoers
		sleep 1
	    echo "bkuser sudo已成功添加"
	    exit
	fi

fi


