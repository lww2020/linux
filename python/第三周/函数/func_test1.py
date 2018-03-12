#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# 函数
def func1():
	"""testing1"""
	print('in the func1')
	return 0    # 有返回值
# 调用函数
#func1()

# 过程
def func2():
	"""testing2"""
	print("in the func2")
				# 无返回值
# 调用过程
#func2()

x = func1()
y = func2()

print("from func1 return {}".format(x))
print("from func2 return {}".format(y))
