#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie

import copy
person = ["name",['saving','100']]
p1 = person[:]
p2 = person[:]
print(person)
print(p1)
print(p2)
p1[0] = "davie"
p2[0] = "LiLy"
p1[1][1]=50
print(p1)
print(p2)
'''
# 三种浅拷贝方法：
p1=copy.copy(person)
p2=person[:]
p3=list(person)
'''
