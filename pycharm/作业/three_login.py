#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
1、用户密码文件：users_info
2、用户锁定文件：locked_info

需求：
    用户输入用户名和密码，输入错误超过3次，提示账号被锁定；
    否则登陆成功，显示欢迎登陆
"""
count = 0 # 输入三次后确定是否继续,计数器
lock_num = 1 # 三次密码错误后锁定，计数器
t_flag = False
while not t_flag:
    count += 1 # 计数器
    if count <=3: # 输入次数小于等于3次，则提示输入账号和密码
        username = input("请输入用户名: ")
        password = input("请输入密码: ")
    elif count >=3: # 输入三次后，确认是否需要继续
        user_choice = input("确定是否需要继续! y/n:").strip()
        if user_choice == "y":
            count = 1
            username = input("请输入用户名: ")
            password = input("请输入密码: ")
        elif user_choice == "n":
            exit("已退出，再见！")
            # username = input("请输入用户名: ")
            # password = input("请输入密码: ")
    # with open("users_info",mode="r",encoding="utf-8") as f_read,\
    #         open("locked_info",mode="r+",encoding="utf-8") as f_write:
    with open("users_info", mode="r", encoding="utf-8") as f_read,\
            open("locked_info", mode="r+", encoding="utf-8") as f_write:
        for lock in f_write:
            user = lock.strip()
            if username == user:
                print("账号已经被锁定，请联系管理员解锁.")
                exit("已退出，再见！")
                break
        else:
            for line in f_read:
                user = line.strip().split("|")[0]
                pwd = line.strip().split("|")[1]
                if username == user:
                    if password == pwd:
                        print("登陆成功！")
                        t_flag = True
                        break
                    else:
                        print("当前locl_num = ",lock_num)
                        if lock_num >= 3:
                            print("你输入的密码错误次数超过三次，账号已被锁定，请联系管理员!")
                            lock_num = 0
                            break
                        print("密码输入错误，请重新输入!")
                        break
            else:
                print("账号不存在，请重新输入")  # 账号不存在，重新输入
                t_flag = True
                break
    lock_num += 1