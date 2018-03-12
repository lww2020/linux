#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
input_count = 0  # 输入计算器
lock_count = 0  # 三次密码错误后锁定计算器
while 1:
	input_count += 1  # 输入计数器
	if input_count <= 3:  # 输入次数小于等于3次，则提示输入账号
		user_name = input("请输入用户名: ")
		password = input("请输入密码: ")
	with open("passwords_file.py", mode="r", encoding="utf-8") as f_read, \
			open("lock_users_file.py", mode="r+", encoding="utf-8") as f_write:
		for lock in f_write:  # 判断账户是否被锁定
			lock_user = lock.strip()
			if user_name == lock_user:
				print("账号已被锁定，请联系管理员!")
				break
		else:
			for line in f_read:
				_user_name = line.strip().split("|")[0]
				_password = line.strip().split("|")[1]
				if user_name == _user_name:
					if password == _password:
						print("登陆成功")
						lock_count = 0
						break
					else:
						print(lock_count)
						if lock_count >= 3:
							f_write.write(_user_name + "\n")
							print("你连续三次输入错误，账号被锁定，请联系管理员!")
							lock_count = 0
							break
						print("密码输入有误，请重新输入")
						break
			else:
				print("密码输入错误，请重新输入")
	lock_count += 1
	input_count += 1
