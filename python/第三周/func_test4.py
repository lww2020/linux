#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
def test01():
	pass
def test02():
	return 0
def test03():
	return 0,10,'hello',['alexl','lb'],{'name':'alxe'}
	#return test02()
t1 = test01()
t2 = test02()
t3 = test03()
print('from test01 return is [%s]:' %type(t1),t1)
print('from test02 return is [%s]:' %type(t2),t2)
print('from test03 return is [%s]:' %type(t3),t3)
'''
总结：
1、返回值数=0，返回None
2、返回值数=1，返回object
3、返回值数>1，返回tuple
'''
