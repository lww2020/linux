#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# 集合操作
list_1 = [1,4,6,7,3,6,7,9]
list_1 = set(list_1)
list_2 = set([2,6,0,66,22,8,4])
print(list_1,list_2)

# 交集
print(list_1.intersection(list_2))

# 并集
print(list_1.union(list_2))

# 差集,在list_1 but not ni list_2
print(list_1.difference(list_2))

# 差集，在list_2， but not in list_1
print(list_2.difference(list_1))

# 子集
list_3 = set([1,3,7])
# list_3是否为list_1的子集
print(list_3.issubset(list_1))
# list_1是否为list_3的父级
print(list_1.issuperset(list_3))

#  对称差集，互相没有的元素，去掉重复的元素
print(list_1.symmetric_difference(list_2))
print(list_2)
print(list_3)
# list3的元素不在list2中，返回True
print(list_3.isdisjoint(list_2))

# 如果有一个元素相同，就有交集，返回False
list_4 = set([5,6,8,7])
print(list_3.isdisjoint(list_4))

print(list_1 & list_2)  # 交集
print(list_2 | list_1) #  并集
print(list_1 - list_2) # 差集，在一中，但不在2中
print(list_1 ^ list_2) # 对称差集

list_1.add(999)
print(list_1)

list_1.remove(4)
print(list_1)
len(list_1)
print(9 not in list_1)

print(list_1.pop())
print(list_1.pop())
print(list_1)
list_1.discard(999)
print(list_1)



