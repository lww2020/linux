#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
age = 26
count = 0

print("-----begin-----")
while count < 3:
	count += 1
	_age = int(input("请输入您所猜的年龄: "))
	if _age == age:
		print("恭喜您猜对了.")
		print("-----end----")
		break
	elif _age > age:
		print("本次您猜的比实际的大，请下次猜小一点.")
		if count == 3:
			print("连续3次错误...")
			print("-----end----")
	else:
		print("本次您猜的年龄比实际的小，请下次猜小一点.")
		if count == 3:
			print("连续3次错误...")
			print("-----end----")
