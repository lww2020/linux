#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
函数返回值
函数外部的代码想要获取函数的执行结果，就可以在函数里用return语句
把结果返回

注意：
1、函数在执行过程中只要遇到return语句，就会停止执行并返回结果，so，
也可以理解为return语句代表着函数的的结束
2、如果未在函数中指定return，那这个函数的返回值为None
3、函数永远返回一个值，用逗号隔开，返回一个元组、列表
"""
def stu_register(name,age,course='PY',country='CN'):
	print("-----注册学生信息-----")
	print("姓名：",name)
	print("年龄：",age)
	print("国籍：",country)
	print("课程：",course)
	if age > 22:
		return False
	else:
		return True

registriation_status = stu_register("王山炮",22,course="PY全栈开发",country='JP')
if registriation_status:
	print("注册成功")
else:
	print("too old to be a student.")

#
