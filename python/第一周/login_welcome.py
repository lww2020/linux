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
while count <3:
    _username = input("请输入用户名: ")
    _password = input("请输入密码: ")
    if _username ==  username and _password ==  password:
        print("恭喜你,成功登陆...")
        break
    else:
        print("第{}次登陆失败".format(count+1),"!!!")
        count += 1
        if count == 3:
            print("连续三次登陆失败，账号已被锁定!!!")