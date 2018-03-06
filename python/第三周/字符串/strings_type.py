#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
 数据类型-字符串
 字符串是一个有序的字符的集合，用于存储和表示基本的
 文本信息，一对单、双或者三引号中间包含的内容称之为
 字符串
创建：
	s = 'Hell, beauty! How are you?'
	特性：
	1、有序
	2、不可变
"""
s = 'Hello World!'
print(s.capitalize())   # 字符串首字母大写，其他小写
print(s.casefold())     # 全部变成小写，便于比较
print(s.center(50,'*')) # 不足50个字节宽度，用*代替
print(s.count('o'))     # 统计字符的个数
print(s.count('o',0,5)) # 从开始到第5个结束查询统计
print(s.endswith('!'))  # 判断是否以！结尾
s2 = 'a\tb'
s2
print(s2)
print(s2.expandtabs(20))
print(s.find('o'))
print(s.find('o',0,3))
print(s.find('o',0,5))

# format字符串格式化
s3 = 'my name is {0}, i am {1} years old '
print(s3)
print(s3.format('Alex',22))
s4 = 'my name is {name}, i am {age} years old'
print(s4.format(name='alex',age=23))
