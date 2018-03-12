#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
# *args: 接受N个位置参数，转成元组
'''
def test(*args):
	print(args)
test(1,2,3,3,4,5,7,5)
test()*[1,2,3,4,5,5]    # args= tuple([1,2,3,4,5,5])
'''
# def test1(x,*args):
# 	print(x)
# 	print(args)
# test1(1,2,3,4,5,6,7)

# **kwargs: 把n个关键字参数，转换成字典的方式
# def test2(**kwargs):
# 	print(kwargs)
# test2(name='alex',age=22,sex='M')
def test4(name,age=18,*args,**kwargs):
	print(name)
	print(age)
	print(kwargs)
test4('alex'age=34,sex='m',hobby='test1a')
