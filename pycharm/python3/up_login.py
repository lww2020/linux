#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
编写登陆接口
基础需求：
让用户输入用户名密码
认证成功后显示欢迎信息
输错三次后退出程序

升级需求：
可以支持多个用户登录 (提示，通过列表存多个账户信息)
用户3次认证失败后，退出程序，再次启动程序尝试登录时，还是锁定状态（提示:需把用户锁定的状态存到文件里）
deny_users_list.txt 文件内容格式： 用户名
'''
users_list = {
    "uname1":"uname1123",
    "uname2":"uname2123",
    "uname3":"uname3123"
}

lock_user = []
exit_flag = False
count = 0
f = open(file="deny_users_list.txt",mode="a",encoding="utf-8")
f.close()
with open(file="deny_users_list.txt",mode="r",encoding="utf-8") as deny_users_list_f:
    deny_users_list = deny_users_list_f.readlines() # 将文件内容转换为列表
    print("已经被锁定的账号如下: ")
    for locked_user in deny_users_list:
        print(locked_user.strip())
    for i in deny_users_list:
        i=i.strip()
        lock_user.append(i)
while count < 3 and not exit_flag:
    user = input("请输入用户名->: ".strip())
    if user in lock_user:
        print("%s账号被锁定，请联系管理员解锁后重新尝试..."%user)
        exit_flag = True
    elif user not in users_list:
       count += 1
       if count == 1:
            print("用户名第1次错误")
       if count == 2:
            print("用户名第2次错误")
       if count == 3:
            print("用户名连续3次错误，程序退出...")
    else:
        while count < 3 and not exit_flag:
            pwd = input("请第%s次输入密码->: "%(count+1)).strip()
            if pwd == users_list[user]:
                print("登陆成功，欢迎您!")
                exit_flag = True
            else:
                count += 1
                print("%s次输入用户名错误,第%s次密码错误...")
                continue
    if count >= 3:
        if user == "":
            print("您输入的错误次数过多，且为空")
        elif user not in users_list:
            print("您输入的次数过多，且最后一次输入的用户%s不存在"%user,'该用户已经被锁定')
            with open(file="deny_users_list.txt",mode="a",encoding="utf-8") as deny_users_list_f:
                if user not in users_list:
                    deny_users_list_f.write(user+"\n")