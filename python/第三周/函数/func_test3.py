#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
def  test1():
	print('in the test1')
def test2():
	print('in the test2')
	return 0
def test3():
	print('in the test3')
	return 1,'hello',['alex','wupeiqi'],{'name':'alex'}
x = test1()
y = test2()
z = test3()
print(x)
print(y)
print(z)

"""
总结：
1、返回值数=0：返回None
2、返值数=1：返回object
3、返回数>1：返回tuple
"""