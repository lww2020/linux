#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
实现用户输入用户名和密码,当用户名为 seven 且 密码为 123 时,显示登陆成功,否则登陆失败!
'''
name = 'seven'
pwd = '123'
i_name = input("用户名->: ")
i_pwd = input("密码->: ")
if i_name == name and i_pwd == pwd:
    print("登陆成功.")
else:
    print("登陆失败!")