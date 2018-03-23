#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
输入一年份，判断该年份是否是闰年并输出结果。（编程题）
注：凡符合下面两个条件之一的年份是闰年。
（1） 能被4整除但不能被100整除。
（2） 能被400整除。
'''

count = 0
while count < 3:
    count += 1
    year = input("请输入年份->: ")
    if year.isdigit():
        year = int(year)
        if (year %100 !=0 or year % 400 == 0) and year % 4 == 0 :
            print(year,'是闰年')
        else:
            print(year,"是平年")
    else:
        print("您输入的年份有误")
    if count == 1:
        print("第一次")
    elif count == 2:
        print("第二次")
    elif count == 3:
        print("第三次结束")
        break

