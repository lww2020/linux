#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# 读写模式
# f = open(file="girls_info.txt",mode="r+",encoding="utf-8")
# data = f.read()
# print(data)
# f.write("\nnewline 1哈哈")
# f.write("\nnewline 2哈哈")
# f.write("\nnewline 3哈哈")
# f.write("\nnewline 4哈哈")
# print("content",f.read())
# f.close()

#写读模式
f = open(file="girls_info.txt",mode="w+",encoding="utf-8")
data = f.read()
print("content ",data)
f.write("\nnewline 1哈哈")
f.write("\nnewline 2哈哈")
f.write("\nnewline 3哈哈")
f.write("\nnewline 4哈哈")
print("new content",f.read())
f.close()