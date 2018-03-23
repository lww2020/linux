#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
实现用户输入用户名和密码,当用户名为 seven 或 alex 且 密码为 123 时,显示登陆成功,否则登陆失败,失败时允许重复输入三次
'''
name1 = 'seven'
name2 = 'alex'
pwd = '123'
count = 0
while count <3:
    i_name = input("用户名->: ")
    i_pwd = input("密码->: ")
    if (i_name == name1 or i_name == name2) and i_pwd == pwd:
        print("登陆成功.")
        break
    else:
        if count == 0:
            print("第1次失败登陆失败!")
        elif count == 1:
            print("第2次失败登陆失败!")
    count += 1
    if count == 3:
        print("连续3次失败，程序退出!")
        break