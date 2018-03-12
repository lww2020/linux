#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
username = "davie"
password = "daviepwd"
count = 0
while count < 3:
	_username = input("请输入用户名: ".strip())
	_password = input("请输入密码: ".strip())
	if _username == username and _password == password:
		print("\033[32m登陆成功，欢迎你.\033[0m")
	else:
		if count == 0:
			print("\033[31m你第一次输入错误!\033[0m")
		elif count == 1:
			print("\033[31m你第二次输入错误!\033[0m")
		else:
			print("\033[31m你连续三次输入错误，程序退出!")
	count += 1
