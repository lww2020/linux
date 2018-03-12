#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
names=['shanshan','Longting','Alex',1,3,4,5,6,7,7,8,8,9,9,0,0,2,3,4]
print(names)
names.append('Peiqi')   # 追加
print(names)
names.insert(0,'abc')
print(names)
names.insert(names.index('Longting'),'DaWang')  #  嵌套
print(names)

# 修改
names[names.index('shanshan')] = 'YinJiaoDaWang'
print(names)

# 删除方法一
names.pop()
print(names)
names.remove('abc')
print(names)

# 删除方法二
del names[names.index('Longting')]
print(names)

# 循环列表元素
for i in names:
	print(i)

n = ['a','e','b',1.34,2,'c']
print(n)

