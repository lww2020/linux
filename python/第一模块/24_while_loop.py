#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
count = 0
while count <3:
	age = int(input("请输入年龄: "))
	if age >0 and age <100:
		if age == 26:
			print("恭喜你才对了!")
			break
		elif age > 26:
			print("你这次猜大了，请下次猜小一点.")
		else:
			print("你这次猜小了，请下次猜大一点.")
	count += 1
	if count == 3:
		print("你已经连续3次猜错，退出!")
		break