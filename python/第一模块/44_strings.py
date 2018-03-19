#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
数据类型-字符串
字符串是一个有序的字符的集合，用于存储和表示基本的文本信息，
一对单、双或者三引号中间包含的内容称为字符串。
特性：
1、有序
2、不可变
"""
s = "Hello, world!"
print(s.capitalize())   # 整个字符串的的第一个首字母大写，其余为小写
print(s.casefold())     # 忽略大小写，统一为小写，方便比较
print(s.center(50,'-')) # 50为宽度，字符串#为指定的填充符号，只能是一个
print(s.count("o"))     # 统计o个数
print(s.count("o",0,8)) # 从0到8字节之间，统计o个数
print(s.endswith("!"))  # 判断是否以!结尾
print(s.expandtabs(20)) # 扩展tab键为20字节长度
print(s.find("o"))      # 找到第一个o的位置
print(s.find("o",6,10)) # 从第6个字节开始到第10个字节，查找o的索引位置
# format格式化输出
sname = "My name is {0}, and I am {1} years old this year!"
print(sname.format("alex",28))

sname = "My name is {name}, and I am {age} years old this year!"
sname.format(name="alex", age=27)

## 常用的方法
sname.isdigit()
sname.replace()
sname.find()
sname.strip()
sname.center()
sname.split()
sname.format()
sname.join()

