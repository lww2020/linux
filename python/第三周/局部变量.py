#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# school = 'Oldboy edu'
# def change_name(name):
# 	global school
# 	school = "Mage Linux"
# 	print('before change:',name,school)
# 	name="Alex Li"  # 这个函数就是这个变量的作用域
# 	age = 23
# 	print("after change: ",name)
# print(school)
# name = 'alex'
# change_name(name)
# print(name)
# print('scholl:',school)
#
#

names = ["Alex","Jack","Rain"]
def change_name():
	names[0] = "金角大王"
	print('inside function:',names)
	
change_name()
print('outside function:',names)
"""
 全局变量与局部变量
 在子程序中定义的变量称为局部变量，在程序的一开始定义的变量
 称为全局变量。
 全局变量作用域是整个程序，局部变量作用域是定义该变量的子程序。
 当全局变量与局部变量同名时：
 在定义局部变量的子程序内，局部变量起作用；在其它地方全局变量起作用。
"""