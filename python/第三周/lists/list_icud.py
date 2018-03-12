#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
L2 = ['a','b','c','d','a','e',1,2,4]
print(L2[2])   # 通过索引取值
print(L2[-1])  # 通过索引从列表的右边开始取值
print(L2[-2])  # 通过索引从列表的右边开始取值
print(L2.index('a'))    # 返回指定元素的索引值，从左到右查询，找到第一个匹配的
print(L2.count('a'))    # 统计指定元素的个数
print(L2[L2.index(4)])
print(L2[0:3]) # 顾头不顾尾
print(L2[3:7])
print(L2)
print(L2[-5:])  # 后5位
print(L2[:3])   # 前3位
print(L2)       # 取出所有的
print(L2[:])    # 取出所有的
print(L2[:7:2]) # 步长为2
print(L2[::3])  # 步长为2