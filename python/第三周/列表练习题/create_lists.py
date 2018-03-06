#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
1、创建一个空列表，命名为names，往里面添加old_drive,rain,jack,shanshan,
peiqi,balck_gril元素
"""
names = []
names.extend(['old_driver','rain','jack','shanshan','peiqi','black_gril'])
print(names)

"""
2、往names列表里black_gril前面插入一个alex
"""
names.insert(names.index('black_gril'),'alex')
print(names)

"""
3、把shanshan的名字改成中文：姗姗
"""
names[names.index('shanshan')] = '姗姗'
print(names)

"""
4、往names列表里rain的后面插入一个子列表，[oldboy，oldgirl]
"""
names.insert(names.index('rain')+1,'[oldboy,olbgirl]')
print(names)

"""
5 、返回peiqi的索引值
"""
print(names.index('peiqi'))

"""
6、创建新列表：[1,2,3,4,2,5,6,2],合并入到names列表
"""
names_new = [1,2,3,4,2,5,6,2]
print(names_new)
names.extend(names_new)
print(names)

"""
7、取出names列表中索引4-7的元素
"""
print(names[4:7])

"""
8、取出names列表中索引位2-10的元素，步长为2
"""
print(names[2:10:2])

"""
9、取出names列表中最后3个元素
"""
print(names)
print(names[-3:])

"""
10、循环names列表，打印每个元素的索引值，和元素
"""
for idx,val in enumerate(names):
	print(idx,val)
"""
# 11、循环names列表，打印每个元素的索引值，和元素，当索引值为偶数时，
# 	把对应的元素改为-1
# """
for index,v in enumerate(names):
	if index%2 == 0:
		names[index] = -1
		print(index,v)
print(names)
"""
12、names里有3个元素，请返回第2个2的索引值。不要人肉数，要动态找
	(提示：找出第一个2的位置，在此基础上再找第二个2)
"""
names.insert(5,2)
print(names)

first_index = names.index(2)
new_list = names[first_index+1:]
second_index = new_list.index(2)
second_val = names[first_index+second_index+1]
print(new_list,first_index,second_index)
print('second values:', second_val)

