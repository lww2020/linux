#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
文件处理
给你一个文件"girls_info.txt"，如何查看内容？
1、安装文本编辑器软件
2、选中右键，利用文本编辑器软件打开
3、查看or写入
4、保存、关闭

Python文件处理
文件操作分为读、写、修改，我们先从读开始学习
f = open(file='girls_info.txt',mode='r',encoding='utf-8')
data = f.read()
f.close()