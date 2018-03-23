#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
练习2：猜年龄游戏升级版 (10分钟)
要求：
允许用户最多尝试3次
每尝试3次后，如果还没猜对，就问用户是否还想继续玩，如果回答Y或y, 就继续让其猜3次，以此往复，
如果回答N或n，就退出程序
如何猜对了，就直接退出
'''
count = 0
age = 33
while count < 3:
    count += 1
    age_input = int(input("请输入您猜的年龄-->:"))
    if age_input == age:
        print("恭喜您，猜对了")
        break
    elif age_input > age:
        print("您猜的年龄大于实际年龄，请下次往小一点猜")
    else:
        print("您猜的年龄小于实际年龄，请下次往大一点猜")
    if count == 3:
        choice = input("连续3次猜错,是否继续，y/n: ")
        if choice == "Y" or choice == "y":
            count = 0
        elif choice == "N" or choice == "n":
            break
        else:
            print("你输入的有误，程序结束")