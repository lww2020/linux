#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
数据类型-集合
集合关系测试
1、交集
2、差集
3、并集
"""
iphone7 = {'alex','rain','jack','old_driver'}
iphone9 = {'alex','jack','shanshan','old_boy'}
# 交集
iphone7.intersection(iphone9)
iphone7 & iphone9

# 差集
iphone7.difference(iphone9)
iphone7 - iphone9

iphone9.difference(iphone7)
iphone9 - iphone7

# 并集
iphone7.union(iphone9)
iphone7 | iphone9
