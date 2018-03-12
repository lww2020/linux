#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
	数据类型-集合
如何找出同时买了Iphone7和8的人？
集合是一个无序的，不重复的数据组合，它的主要作用如下：
1、去重，把一个列表变成集合，就自动去重了
2、关系测试，测试两组数据之间的交集、差集、并集等关系

集合中的元素有三个特征：
1、确定性(元素必须可hash)
2、互异性(去重)
3、无序性(集合中的元素没有先后之分)，如集合(3,4,5)和(3,5,4)(算作同一个集合)
"""
iphone7 = ['alex','rain','jack','old_driver']
iphone8 = ['alex','shanshan','jack','old_boy']
lis_both = []
for name in iphone8:
	if name in iphone7:
		lis_both.append(name)
print(lis_both)