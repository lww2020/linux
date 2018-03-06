#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
list_1 = [1,4,5,7,3,6,7,9]
list_1 = set(list_1)
print(list_1)

list_2 = set([2,6,0,66,22,8,4])
print(list_2)

# 交集
print('交集：',list_1.intersection(list_2))

# 并集
print('并集：',list_1.union(list_2))

# 差集
print('差集1：',list_1.difference(list_2))
print('差集2：',list_2.difference(list_1))

# 子集
list_3 = set([1,3,7])
print('子集1：',list_1.issubset(list_2))
print('子集2：',list_2.issubset(list_2))
print('子集3：',list_3.issubset(list_1))
print('父集：',list_1.issuperset(list_3))

# 反向差集
print('反向差集：',list_1.symmetric_difference(list_2))

print('--------------------')
#list_2.isdisjoint()
list_4 = set([5,6,8])
print(list_3)
print(list_4)
print(list_3.isdisjoint(list_4))

# 交集 &
print(list_1 & list_2)

# 并集 |
print(list_2 | list_1)

# 差集 -
print(list_1 - list_2) # 在1中但不在2中

# 对称差集 ^  在1中或者2中，但不会同时出现在二者中
print(list_1 ^ list_2)

list_1.add(999)
print(list_1)
list_1.update([888,777,555])
print(list_1)

# remove() 可以删除一项：
# 删除不存在的，会报错
# discard 删除不存在的，不会报错
list_1.remove(777)
print(list_1)
list_1.discard(10000)
# 长度 len
print(len(list_1))

# 随机删除并返回
print(list_1.pop())
print(list_1.pop())
print(list_1.pop())
print(list_1)
