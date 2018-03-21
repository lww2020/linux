#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
Set(集合)
集合(set)是一个无序不重复元素的序列。
基本功能是进行成员关系测试和删除重复元素。
可以使用大括号{}或者set()函数创建集合，注意：创建一个空集合必须使用set()而不是{}，
因为{}是用来创建一个空字典。
创建格式：
parame = {value01,value02,...}
或者
set(value)
"""
# 实例
student = {'Tom', 'Jim', 'Mary', 'Tom', 'Jack', 'Rose'}
print(student) # 输出集合，重复的元素被自动去掉
print(type(student))

# 成员测试
if ('Rose' in  student):
    print('Rose 在集合中')
else:
    print("Rose 不在集合中")

# set可以进行集合运算
a = set('abracadabra')
b = set('alacazam')

print(a)
print(b)
print('a-b的差集: ',a-b)  # a和b的差集
print('a和b的并集: ',a | b) # a和b的并集
print('a和b的交集: ',a & b) # a和b的交集
print('a和b中不同时存在的元素: ',a ^ b) # a和b中不同时存在的元素

