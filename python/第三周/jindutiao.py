#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
import sys,time
for i in range(20):
	sys.stdout.write("#")
	sys.stdout.flush()
	time.sleep(0.5)

# "r+" 读写
# "w+" 写读
# "rb" 二进制文件格式读
f = open("yesterday.py2",'w+',encoding="utf-8")
print(f.readline())
print(f.readline())
print(f.readline())
f.write("\n----diao------")
print(f.tell())
f.seek(10)
print(f.readline())
f.write("should be at the begining of second line")

print(f.readline())



