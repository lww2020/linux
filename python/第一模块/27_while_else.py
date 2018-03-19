#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
与其它语言else一般只与if搭配不同，在Python中，还有个
while...else语句
while后面的else作用是指，当while循环正常执行完，中间
没有被break终止的话，就会执行else后面的语句
"""
count = 0
while count <= 10:
	print("Loop： ", count)
	if count == 4:
		break
	count += 1
else:
	print("Loop has done.")
print("----- 循环结束 -----")
