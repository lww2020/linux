#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
文件操作
对文件操作流程
1、打开文件，得到文件句柄并赋值给一个变量
2、通过句柄对文件进行操作
3、关闭文件
"""
#data = open("yesterday.py",encoding="utf-8").read()
#f = open("yesterday.py2","r",encoding="utf-8",)  # 文件句柄
# a = append 追加
'''
f.write("I love beijing tian an men! \n")
f.write("Tian men shang sheng tai yang!\n")

#  打印前5行
for i in range(5):
	print(f.readline())
'''
"""
# low loop
for index,line in enumerate(f.readlines()):
	if index == 9:
		pass
		#print("--我是第10行---")
		continue
	print(index,line.strip())

# high bige
count = 0
for line in f:
	if count == 9:
		print('---我是分隔符---')
		count += 1
		continue
	print(line.strip())
	count += 1
"""
f = open("yesterday.py2",'w',encoding="utf-8") # 文件句柄
print(f.tell()) #  句柄指针打印出来
print(f.readline())
print(f.readline())
print(f.readline())
print(f.tell())
f.seek(0)
print(f.readline().strip())
print(f.encoding)
print(f.fileno())
print(f.isatty())
print(f.readable())
print(f.flush())
print(dir(f.buffer))
f.write()

f.close()

