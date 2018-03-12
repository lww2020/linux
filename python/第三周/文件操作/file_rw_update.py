#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
#f = open("yesterday2",'r',encoding="utf-8") # 文件句柄
# for i in range(5):
# 	print(f.readline())

# # low loop
# #print(f.readlines())
# for index,line in enumerate(f.readlines()):
# 	if index == 9:
# 		print('--------我是分隔符----------')
# 		continue
# 	print(index,line.strip())
# high loop
f = open("yesterday2",'r',encoding="utf-8") # 文件句柄
count  = 0
for line in f:
	if count == 9:
		print("-----我是分隔符-----")
		count += 1
		continue
	print(count,line.strip())
	count += 1

f.close()


