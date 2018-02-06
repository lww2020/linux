# -*- coding:utf-8 -*-
# Author: davie
# 表达式if ... else
"""
场景一：用户登陆验证
1、提示用户输入用户名和密码
2、验证用户名和密码
    如果错误，则输出用户名或密码错误
    如果成功，则输出欢迎，xxx！
"""
import  getpass
name = "davie"
pwd = "abc123"
_name = input("请输入用户名：")
_pwd = input("请输入密码：")
if _name == name and _pwd == pwd:
    print("欢迎,{}".format(name),'!')
else:
    print("用户名或密码错误!!!")