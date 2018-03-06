#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
11、按照要求实现以下功能：
	现有一个列表， li = [1,2,3,'a','b',4,'c'],有一个字典(此字典是动态生成的，你并不知道他里面有多少键值对，所以用dic =
	{} 模拟此字典);现在需要完成这样的操作：如果该字典没有键'k1'这个键,那就创建这个'k1'键和其对应的值(该键对应的值设置为空列
	表),并将列表中的索引为奇数对应的元素，添加到'k1'这个键对应的空列表中。如果该字典中有'k1'这个键，且k1对应的value
	是列表类型，那就将列表li中索引位为奇数对应的元素，添加到'k1'，这个键对应的值中。
"""
li = [1,2,3,’a’,’b’,4,’c’]
li1 = []
dic = {"k1":li1}
# 如果字典中没有k1这个键
if "k1" not in dic:
	for i in dic:
		if i in li:
			if li.index(i) % 2 == 0:
				li1.append(i)
	print(li1)
	dic["k1"] = li1
	print(dic)
# 如果字典中有k1这个键
else:
	if type(li1) = list:
		for i in li:
			if li.index(i) % 2 == 0:
				li1.append(i)
			dic["k1"] = li1
		print(dic)