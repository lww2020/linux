#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
1、面向对象
2、面向过程
3、函数式编程
'''
# 定义函数
def func1():
	"testing function"
	print("in the func1")
	return 0

# 定义过程
def func2():
	'''testring2'''
	print("in the func2")
	
#  调用函数
x = func1()
y = func2()

# 过程就是没有返回值的函数

print('from func1 return is %s' %x)
print('from func2 return is %s' %y)