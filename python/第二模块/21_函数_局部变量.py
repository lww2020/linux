#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
定义在函数外部的一级代码的，叫全局变量，全局都能用

局部变量：
	就是指定义在函数里的变量，只能在局部生效，在函数内部可以应用全局变量
	如果，全局和局部都有名字相同的变量，函数查找变量的顺序
是由内而外的。
"""


name = "Black girl"
def change_name():
	name = "黑姑娘"
	print("在",name,'里面...',id(name))
change_name()
print(name,id(name))