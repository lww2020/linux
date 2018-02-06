#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
作业二：编写登陆接口

    输入用户名密码
    认证成功后显示欢迎信息
    输错三次后锁定
'''
username = "davie"
password = "abc123"
count = 0
while count < 3:
    _username = input("请输入用户名：")
    _password = input("请输入密码: ")
    if _username == username and _password == password:
        print("成功：欢迎光临！")
        break
    else:
        print("失败，用户名或者密码错误!!!")
    count += 1
else:
    if count == 3:
        print("你已经连续3次输入错误，程序已经退出!!!")