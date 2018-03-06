#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
f = open("yesterday2",'r',encoding="utf-8") # 文件句柄
print(f.tell())
print(f.readline())
print(f.readline())
print(f.readline())
print(f.tell())
f.seek(0)
print(f.readline())

print(f.encoding)
print(f.fileno())
print(f.flush())
"""

# f = open("test2",'w',encoding="utf-8")
# f.write("Hello, world!\n")
# f.write("Hello, world2!\n")
# f.flush()
# 打印进度条
# import sys,time
# for i in range(50):
# 	sys.stdout.write("#")
# 	sys.stdout.flush()
# 	time.sleep(0.5)
f = open("yesterday2",'a',encoding="utf-8") # 文件句柄
f.seek(10)
f.truncate(20)

