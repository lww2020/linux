#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
写代码，有如下字典，按照要求实现每一个功能dic = {'k1':'v1','k2':'v2','k3':'v3'}
1、请循环遍历出所有的key
2、请循环遍历出所有的value
3、请循环遍历出所有的key和value
4、请在字典中添加一个键值对,'k4':'v4',输出添加后的字典
5、请删除字典中键值对'k1','v1'，并输出删除后的字典
6、请删除字典中的键'k5'对应的键值对，如果字典中不存在键'k5',则不报错，并且让其返回None
7、请获取字典中'k2'对应的值
8、请获取字典中'k6'对应的值，如果键'k6'不存在，则不报错，并且让其返回None
"""
# 获取字典中不存在的kv，不报错,且返回None
dic = {'k1':'v1','k2':'v2','k3':'v3'}
print('k6 is not exist: ',dic.get('k6'))
