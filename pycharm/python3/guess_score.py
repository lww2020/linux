#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
再来个匹配成绩的小程序吧，成绩有ABCDE5个等级，与分数的对应关系如下

A    90-100
B    80-89
C    60-79
D    40-59
E    0-39
"""
score = 100
s_input = int(input("请输入0-100之间的数字>: "))
if s_input < 0 or s_input > 100:
    print("成绩不能小于0或者不能大于100")
elif s_input > 90:
    print(s_input,"成绩优良: A")
elif s_input > 80:
    print(s_input,"成绩优秀：B")
elif s_input > 60:
    print(s_input,"成绩及格：C")
elif s_input > 40:
    print(s_input,"成绩不及格: D")
else:
    print(s_input,"成绩极差: E")
