#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
对文件操作流程
1、打开文件，得到文件句柄并赋值给一个变量
2、通过句柄对文件进行操作
3、关闭文件
"""
# data = open("yesterday",encoding="utf-8").read()
# print(data)
# f = open("yesterday","w",encoding="utf-8")  # 文件句柄，文件内存对象
# data = f.read()
# data2 = f.read()
# print(data)
# print('')
# f.write('我爱北京天安门，天安门前太阳升起！')
f = open("yesterday2",'r+',encoding="utf-8")     # 文件句柄数
# a 模式是append的意思
# w 模式是写的意思
# r 模式是读的意思
f.write('我爱北京天安门,\n')
f.write('天安门前太阳升！\n')
f.write('中国出了个毛主席')
f.read()
f.close()