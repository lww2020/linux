#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
f = open("yesterday2",'w+',encoding="utf-8") # 文件句柄
# r+ : 读写
# w+ : 写读 , 很少用
# a+ : 追加读写
# rb ：二进制文件

f.write("----------dir1---------------\n")
f.write("----------dir1---------------\n")
f.write("----------dir1---------------\n")
f.write("----------dir1---------------\n")
print(f.tell())
f.seek(10)
print(f.readline())
print("should be at the begining  of the senecond line")
f.close()


