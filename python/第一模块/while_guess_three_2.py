#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# 允许猜3次，如果输入y，可以继续重复
age = 26
count = 0
print("-----begin-----")
while count < 3:
	count += 1
	_age = int(input("请输入您猜的年龄: "))
	if _age == age:
		print("恭喜你猜对了.")
		print("----- end -----")
	elif _age > age:
		print("本次猜大了,下次猜小一点.")
		if count == 3:
			choice = input("您已经连续3次猜错。是否继续: y/n").strip()
			if choice == "y" or choice == "Y":
				count = 0
			else:
				print("----- end -----")
				break
	else:
		print("本次猜小了,下次猜小一点.")
		if count == 3:
			choice = input("您已经连续3次猜错。是否继续: y/n").strip()
			if choice == "y" or choice == "Y":
				print("-----begin-----")
				count = 0
			else:
				print("----- end -----")
				break
