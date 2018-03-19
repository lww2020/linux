#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
写代码：有如下字典
按照要求实现每一个功能
dict = {"k1":"v1","k2":"v2","k3":"v3"}
"""
dict = {"k1":"v1","k2":"v2","k3":"v3"}
#1、请循环遍历出所有的key
for k in dict:
	print(k)

#2、请循环遍历出所有的value
for k in dict:
	print(dict[k])
#3、请循环遍历出所有的key和value
for k in dict:
	print(k,dict[k])
	
#4、请在字典中增加一个键值对,"k4":"v4"，输出添加后的字典
dict = {"k1":"v1","k2":"v2","k3":"v3"}
print("dict原来的值: ",dict)
dict["k4"] = "v4"
print("dict新增\"k4\":\"v4\"后的值: ",dict)

#5、请删除字典中键值对"k1":"v1",并输出删除后的结果
dict = {"k1":"v1","k2":"v2","k3":"v3","k4":"v4"}
print("dict删除k1前的值: ",dict)
dict.pop("k1")
print("dict删除k1后的值: ",dict)

#6、请删除字典中键"k5"对应的键值对，如果字典中不存在键"k5",则不报错，返回None
dict = {"k1":"v1","k2":"v2","k3":"v3","k4":"v4"}
print(dict)
print("删除不存在的k5,不报错，返回值: ",dict.pop("k5",None))

# 7、请获取字典中"k2"对应的值
dict = {"k1":"v1","k2":"v2","k3":"v3","k4":"v4"}
print(dict["k2"])

#8、请获取字典中"k6"对应的值,如果不存在，则不报错，并且让其返回None。
dict = {"k1":"v1","k2":"v2","k3":"v3","k4":"v4"}
print("dict值: ",dict)
print(dict.get("k6",None))

#9、现有dict2 = {"k1":"v11","a":"b"},通过一行操作使dict2 = {"k1":"v1","k2":"v2","k3":"v3","a":"b"}
dict = {"k1":"v1","k2":"v2","k3":"v3"}
dict2 = {"k1":"v11","a":"b"}
dict2.update(dict)
print("dict: ",dict)
print("dict2: ",dict2)

#10、组合嵌套题。写代码，有如下列表，按照要求实现每一个功能
"""
lis = [["k",["qwe",20,{"k1":["tt",3,"1"]},89],"ab"]]
10.1、将列表中的数字变成字符串"100"(用两种方法)
10.2、将列表中的字符串"1"变成数字101(用两种方法)
"""
# 10.1 方法1:
print(lis[0][1][2].get("k1")[0].upper())
# 10.1 方法2:
print(lis[0][1][2].get("k1")[0].swapcase())

# 10.2 方法1:
lis[0][1][2]["k1"][2] = 101
# 10.2 方法2:
lis[0][1][2].get("k1")[2]=101

# 11、按照要求，实现如下功能：
"""
现有一个列表li = [1,2,3,'a',4,'c'],有一个字典(此字典是动态生成的，你并不知道他里面有多少
键值对，所以用dic={}模拟字典；现在需要完成这样的操作：如果该字典没有"k1"这个键，那就创建
这个"k1"键和对应的值(该键对应的值为空列表)，并将列表li中的索引位为奇数对应的元素，添加到
"k1"这个键对应的空列表中。如果该字典中有"k1"这个键，且k1对应的value是列表类型。那就将该列表li
中的索引位为奇数对应的元素，添加到"k1"，这个键对应的值中。
"""
dic = {}
li = [1,2,3,'a',4,'c']
if "k1" not in dic:
	dic.setdefault("k1",[])
	for i in li:
		if li.index(i)%2 == 1:
			dic["k1"].append(i)
		else:
			if type(dic["k1"]) == type([]):
				for i in li:
					if li.index(i)%2 == 1:
						dic["k1"].append(i)
			else:
				print("字典K1，VALUE不是列表，无法追加")
print(dic)

