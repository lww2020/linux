#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# file three_login.py
"""
需求说明：
1、输入用户名
2、认证成功，提示登录成功，欢迎信息
3、登录失败连续三次，提示失败，并退出程序

备注：
1、users_info是存放用户名及其密码的文件，格式: 用户名 密码， 之间用空格隔开
2、locked_file是存放被锁定的用户id的文件，默认为空，格式为: 用户名
3、程序会对users_info里的合法用户id进行判断，若连续三次输入错误，提示失败并退出
4、程序会对正确的用户名后的密码进行验证，输入三次密码错误，锁定该用户名，并退出
"""
import os,sys,getpass   # 导入os,sys,getpass 模块
os.system('clear')      # 清屏操作
count = 0               # 用户输入循环次数
while count < 3:        # 只要用户登录失败不超过3次，就就行循环执行
    username = input("请输入您的用户名: ").strip()   # 输入用户名
    # 打开locked_file文件，权限是读写，并赋值给locked_f变量
    locked_f = open('locked_file',mode='r+',encoding='utf-8')
    # 使用.readlines()的方法逐行读取locked_file文件，并赋值给locked_list变量
    locked_list = locked_f.readlines()

    # 使用for循环读取locked_file的内容
    for locked_line in locked_list:
        # 使用.strip()的方法去掉换行符
        locked_line = locked_line.strip('\n')
        # 判断用户输入的信息是否在locked_file中存在
        if username == locked_line:
            print("用户:\033[31m%s\033[0m 已经锁定，请联系您的管理员" % username) # 如果存在则打印
            sys.exit(1) # sys模块的exit()方法表示退出
    with open("users_info",mode="r",encoding="utf-8") as user_f: # 只读模式打开文件
        user_list = user_f.readlines()  # 使用.readlines()方法逐行读取，赋值给变量
        
    for user_line in user_list: # 使用for循环读取users_info的内容
        (user,passwd) = user_line.strip('\n').split()   # 分别获取账号和密码信息
        if username == user:    # 使用if判断用户输入的账号是否在users_info中存在
            p_count = 0               # 输入密码的循环次数
            while p_count <3:         # 循环不超过三次
                password = getpass.getpass("请输入密码: ")  # 使用getpass方法，密码不显示
                if password == passwd:  # 用户名和密码都正确
                    print("\033[36m欢迎您，登陆成功!\033[0m")
                    sys.exit(0)
                else:
                    if p_count != 2:  # p=2时，是最后一次机会
                        print("对不起，\033[31m%s\033[0m的密码错误,请继续输入，你还有\033[31m%d\033[0m次机会"%(username,2-p_count))
                p_count += 1
        else:
            pass    # 用户匹配失败，跳过并继续循环
    else:
        locked_f.write(username + '\n')
        sys.exit("对不起 \033[31m%s 用户已经被锁定，请联系管理员\033[0m"% username)
    u += 1
else:
    sys.exit("\033[31输入有误，程序退出，请重新输入!\033[0m")
locked_f.close()      # 关闭文件
