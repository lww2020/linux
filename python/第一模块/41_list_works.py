#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# 1、创建一个空列表，命名为names,往里面添加 old_driver,rain,jack,shanshan,peiqi,black_girl 元素
names = []
names.append("rain")
names.append("jack")
names.append("shanshan")
names.append("peiqi")
names.append("black_girl")
print("names: ",names)

# 2、往names列表里black_gird前面插入一个alex
names.insert(names.index("black_girl"),"alex")
print("names: ",names)

# 3、把shanshan的名字修改成中文：姗姗
names[names.index("shanshan")] = "姗姗"
print("name: ",names)

# 4、往names列表里rain的后面插入一个子列表,[oldboy,oldgirl]
names.insert(names.index("rain")+1,'["oldboy","oldgirl"]')
print("names: ",names)

# 5、返回peiqi的索引值
print("返回peiqi的索引值: ",names.index("peiqi"))

# 6、创建新列表[1,2,3,4,2,5,6,2],合并入names列表
n_list = [1,2,3,4,2,5,6,2]
names.extend(n_list)
print("合并后的names: ",names)

# 7、取出names列表中索引4-7的元素
print("取出names列表中索引4-7的元素: ",names[4:7])

# 8、取出names列表中索引2-10的元素，步长为2
print("取出names列表中索引2-10的元素，步长为2: ",names[2:10:2])

# 9、取出names列表中最后3个元素
print("取出names列表中最后3个元素: ",names[-3:])

# 10、循环names列表，打印每个元素的索引值，和元素
for idx,val in enumerate(names):
	print("1_索引值: 2_元素值",idx,val)

#  11、循环names列表，打印每个元素的索引值，和元素，当索引值为偶数时，
#+ 把对应的元素改成-1
for index,value in enumerate(names):
	if (index % 2) ==0:
		value = -1
	print("1_索引值: 2_元素值",index,value)

########################################################################################
#  12、names里面有3个2，请返回第2个2的索引。不要人肉搜索，要动态找到(提示，
#+ 找到第一个2的位置，在此基础上再找第二个)
print(names)

"""
# 13、现有商品列表如下：
products = [
	['Iphone8',6888],
	['Mac Pro',14800],
	['小米6',2499],
	['Coffee',31],
	['Book',80],
	['Nike',799]
	]
需要打印出这样的格式：
-----------商品列表------------
0. Iphone8 6888
1. MacPro  14800
2、小米6   2499
3、Coffee  31
4、Book    80
5、Nike Shoes 799
"""
products = [
	['Iphone8',6888],
	['Mac Pro',14800],
	['小米6',2499],
	['Coffee',31],
	['Book',80],
	['Nike',799]
	]
print("-----------商品列表------------")
for index,value in enumerate(products):
	print(index,'.',value[0],'\t',value[1])




