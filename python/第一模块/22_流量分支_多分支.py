#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
age = 26
user_guess = int(input("请输入你猜的年龄: "))
if user_guess > 26:
	print("你这次猜的年龄大了，请下次猜大一点!")
elif user_guess < 26:
	print("你这次猜的年龄小了，请下次猜大一点!")
else:
	print("恭喜猜对了!")
"""

"""
成绩匹配小程序
A 90-100
B 80-89
C 60-79
D 40-59
E 0-39
"""
score = int(input("请输入0-100之间的整数: "))
if score <0 or score > 100:
	print("输入有误，请输入0-100之间的整数!")
elif score >=90:
	print("成绩: A")
elif score >= 80:
	print("成绩: B")
elif score >= 60:
	print("成绩: C")
elif score >40:
	print("成绩: D")
else:
	print("成绩: E")
