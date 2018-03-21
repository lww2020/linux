#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
如何找出同时购买了Iphone7和Iphone8的人？
集合是一个无序的，不重复的数据组合，它的主要作用如下：
1、去重，把一个列表变成集合，就自动去重了
2、关系测试，测试两组数据之间的交集、差集、并集等关系
"""
iphone7 = {'alex','rain','jack','old_driver'}
iphone8 = {'alex','jack','shanshan','old_boy'}

# 交集
iphone7.intersection(iphone8)
iphone8 & iphone7

# 差集
iphone7.difference(iphone8)
iphone8.difference(iphone7)

iphone7 - iphone8
iphone8 - iphone7

# 并集
iphone7.union(iphone8)
iphone7 | iphone8

# 反差集
iphone8.symmetric_difference(iphone7) # 只买iphone8或者iphone7