#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
循环终止语句：

如果在循环的过程中，因为某些原因，你不想继续循环了，
怎么把它终止掉了？这就用到break或者continue语句
break用于完全结束一个循环，跳出循环体执行后面的语句
continue和break有点类似，区别在于continue只是终止本次
循环，接着还执行后面的循环，break则完全终止循环体
"""
count = 0
print("---------loop begin---------")
while count <= 100:
	print("loop: ",count)
	if count == 5:
		break
	count += 1
print("---------loop end---------")

# 只要在6到94之间，就不走下面的print语句
count = 0
print("----- loop begin-----")
while count <= 100:
	count += 1
	if count >= 5 and count <= 95:
		continue
	print("loop ",count)
print("----- loop end-----")