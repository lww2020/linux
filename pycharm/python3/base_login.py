#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
编写登陆接口
基础需求：
让用户输入用户名密码
认证成功后显示欢迎信息
输错三次后退出程序
'''
count = 0
name = 'davie'
pwd = 'abc123'
while count < 3:
    count += 1
    u_name = input("请输入用户名->: ").strip()
    if u_name == name:
        pass_word = input("请输入密码->: ").strip()
        if pass_word == pwd:
            print("成功登陆，欢迎你!")
            break
        else:
            if count == 1:
                print("第1次输入的密码有误.")
            elif count == 2:
                print("第2次输入的用户名或密码有误.")
            elif count == 3:
                print("连续第3次输入的用户名或密码有误.")
                break
    else:
        if count == 1:
            print("第1次输入的用户名有误.")
        elif count == 2:
            print("第2次输入的用户名有误.")
        elif count == 3:
            print("连续第3次输入的用户名有误.")
            break