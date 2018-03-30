#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
关键参数：
	正常情况下，给函数传参数要按顺序，不想按顺序就可以用关键字参数，
只需要指定参数名即可(指定了参数名的参数就叫关键字参数)，但记住一个
要求，关键字参数必须放在位置参数(以位置顺序确定对应关系的参数)之后
"""
def stu_register(name, age, course='PY', country='CN')
	print("---------注册学生信息----------")
	print("姓名:", name)
	print("年龄:", age)
	print("国籍:", country)
	print("课程:", course)

# 函数调用
stu_register("王山炮",course='PY',age=22,country='JP')

stu_register("王山炮",course='PY',22,country='JP') # 错误的调用方法
stu_register("王山炮",22,age=25,country='JP')  # 错误的调用方法

