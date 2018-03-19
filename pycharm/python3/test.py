#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
str = "Runoob"
print(str)          # 输出字符串
print(str[0:-1])    # 输出第一到倒数第二个的所有字符
print(str[0])       # 输出字符串第一个字符
print(str[2:5])     # 输出从第三个开始到第五个的字符
print(str[2:])      # 输出从第三个开始到最后的所有字符
print(str * 2)      # 输出字符串两次
print(str + '你好') # 输出字符串两次

print("----------------------")
print("hello\nrunnoob")     # 使用反斜杠(\)+n转义特殊字符
print(r"hello\nrunnoob")    # 在字符串前面添加一个r，表示原始字符串，不会发生转义