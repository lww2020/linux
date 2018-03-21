#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# file
"""
参考资料： https://www.cnblogs.com/brianzhu/articles/6282905.html
需求说明：
1、输入用户名
2、认证成功，提示登录成功，欢迎信息
3、登录失败连续三次，提示失败，并退出程序

Readme：
1、normal_user是存放用户id及其密码的文件
2、lock_file是存放被锁定的用户id的文件，默认为空
3、程序会对normal_user里的合法用户id进行判断，若连续三次输入错误，提示失败并退出
4、程序会对正确的用户名后的密码进行验证，输入三次密码错误，锁定该用户id，并退出
"""
import os,sys,getpass   # 导入os,sys,getpass 模块
os.system('clear')      # 清屏操作
count = 0               # 用户输入循环次数
while count < 3:        # 只要用户登录失败不超过3次，就就行循环执行
    uname_input = input("请输入您的用户名: ").strip()   # 输入用户名
    # 打开lock_file文件，权限是读写，并赋值给lock_f变量
    lock_f = open('locl_file',mode='r+',encoding='utf-8')
    # 使用.readlines()的方法逐行读取lock_file文件，并赋值给lock_list变量
    lock_list = lock_f.readlines()

    # 使用for循环读取lock_file的内容
    for lock_line in lock_list:
        # 使用.strip()的方法去掉换行符
        lock_line = lock_line.strip('\n')
        # 判断用户输入的信息是否在lock_file中


