#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
允许用户最多尝试3次，3次都没猜对的话，就直接退出，如果猜对了，打印恭喜信息并退出
'''
count = 0
age = 33
while count <3 :
    count += 1
    age_input = int(input("请输入您猜的年龄-->:"))
    if age_input > age:
        print("您猜的年龄大于实际年龄，请下次往小一点猜")
    elif age_input < age:
        print("您猜的年龄小于实际年龄，请下次往大一点猜")
    else:
        print("恭喜您，猜对了")
        break
    if count == 3:
        print("连续3次猜错，程序退出")
