#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# *args: 接收N个位置参数，转成元组形式
# **kwargs: 接受N个关键字参数，转成字典的方式
def test(*args):
	print(args)
test(21,20,4,5,5,10)
test(*[1,2,3,4,5,5])    # args=tuple([1,2,3,4,5,5])

# args  可以换成其他的字符
def test1(x,*args):
	print(x)
	print(args)
	
test1(1,2,3,4,5,6,7)

# 接收字典
# **kargs: 把N个关键字参数，转换成字典的方式
def test2(**kwargs):
	print(kwargs)
	print(kwargs['name'])
	print(kwargs['age'])
test2(name='alex',age=8,sex='F')
test2(**{'name':'alex','age':8})

def test3(name,**kwargs):
	print(name)
	print(kwargs)
test3('alex',age=8,sex='m')

# 参数组一定要放在最后
def test4(name,age=18,**kwargs):
	print(name)
	print(age)
	print(kwargs)
test4('alex',sex='m',hobby='testla',age=3)