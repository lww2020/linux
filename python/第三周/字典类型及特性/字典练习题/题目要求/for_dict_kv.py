#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
写代码，有如下字典，按照要求实现每一个功能dic = {'k1':'v1','k2':'v2','k3':'v3'}
1、请循环遍历出所有的key
2、请循环遍历出所有的value
3、请循环遍历出所有的key和value
"""
# 打印所有的key-value
dic = {'k1':'v1','k2':'v2','k3':'v3'}
for kv in dic:
	print("key-value for dic are: ",kv,':',dic[kv])
