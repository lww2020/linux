#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
age = 28
count = 0
while count < 3:
    _age = int(input("请输入你猜的年龄: "))
    if _age == age:
        print("恭喜你，猜对了.")
        break
    elif _age > age:
        print("失败,你猜的年龄比实际的大！")
    else:
        print("失败,你猜的年龄比实际的小！")
    count += 1
else:
    print("你已经连续3次猜错!!!")