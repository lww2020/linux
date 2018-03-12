#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
数据类型-元组
元组其实跟列表差不多，也是存一组数，只不过是它一旦创建，
便不能再修改，所以又叫只读列表
特性：
1、不可变
2、元组本身不可变，如果元组中还包含其他可变元素，这些元素
可以改变
功能：
index
count
切片
使用场景：
1、显式的告知别人，此处数据不可修改
2、数据连接配置信息等
"""
names = ("alex",'jack','eric',['ma',32])
print(names)
names[-1][1] = 33
print(names)