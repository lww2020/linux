#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
如何在一个变量里存储公司的每个员工的个人信息？
names = [['alex',26,'技术部','工程师',1365104608],
		 ['Shanshan',25,'公关部','野模',13374245235],
         ['龙婷',24,'设计部','UI',138242344452]
         ]

数据类型-字典
如何在一个变量里存储公司的每个员工的个人信息？
字典：一种key-value的数据类型，使用就像我们上学用的字典，
通过笔划、字母来查对应页的详细信息内容。
特性：
1、key-value结构
2、key必须可hash、且必须为不可变数据类型、必须唯一
3、可存放任意多值、可修改、可以不唯一
4、无序
5、查找速度快

语法：
info = {
	'stu1101':['longting',24,'design','UI',2333],
	'stu1102':['shanshan',25,'PR','wild model']
}

# 增加
info["stu1103"]=["lili",26,'dev','IT',112322]

"stu1101" in info   # 标准用法
info.get("stu1101") # 获取
info["stu1108"]     # 获取数据，如果不存在，则会报错


info.keys()         # 获取字典的键
info.values()       # 获取字典的值

# 删除
info.pop("stu1103") # 删除并返回被删除的数据
info.popitem()      # 随机删除

for i in  range(9000):
	info[i] = i*i
	
av_catalog = {
	"欧美":{
		"www.youporn.com":["很多免费的，世界最大的","质量一般"],
		"www.pornhub.com":["很多免费的，也很大","质量比youporn.com高点"],
		"letmedothistoyou.com":["很多自拍，高质量的图片很多","资源不多，更新慢"],
		"x-art.com":["质量很高，真的很高","全部收费，屌丝请饶过"]
	},
	"日韩":{
		"tokyo-hot":["质量怎样不清楚，个人已经不喜欢日韩范了","听说是收费的"]
	},
	"大陆":{
		"1024":["全部免费，真好，好人一生平安","服务器在国外，慢"]
	}
}

av_catalog["大陆"]["1024"][1] += ", 可以用爬虫爬下来" # 修改
print(av_catalog["大陆"]["1024"])
