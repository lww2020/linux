#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
age = 28
count = 0
while count < 3:
    _age = int(input("请输入你猜的年龄："))
    if _age == age:
        print("恭喜你猜对了.")
    elif _age > age:
        print("你猜的比实际年龄大！")
    else:
        print("你猜的比实际年龄小！")
    count += 1
    if count == 3:
        choice = input("你已经连续三次猜错，请选择是否继续：y|n：")
        if choice == "Y" or choice == "y":
            count = 0
        else:
            print("已经退出猜年龄游戏！")