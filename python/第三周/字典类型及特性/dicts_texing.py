#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
如何在一个变量里存储公司每个员工的个人信息？
names = [
['Alex',26,'技术部','工程师',13651054608],
['Shanshan',25,'共公关部','野模',13374245235],
['龙婷',24,'设计部','UI',138242344452]
]

字典是一种key-value的数据类型，使用就像我们上学用的字典，
通过笔画、字母来查对应也得详细内容。
特性：
1、key-value结构
2、key必须可hash，且必须为不可变数据类型、必须唯一
3、可存放任意多个值、可修改、可以不唯一
4、无序
5、查找速度快

语法：
info = {
	'stu1101':'TengLan Wu',
	'stu1102':'Longze Luola',
	'stu1103':'Xiaoze Maliya'
}
# 增加
info['stu1104'] = '苍井空'
info

# 修改
info['stu1101'] = '武藤兰'
info
"""
info = {
	'stu1101':'TengLan Wu',
	'stu1102':'Longze Luola',
	'stu1103':'Xiaoze Maliya'
}
print('打印：  info = ',info)
# 增加
info['stu1104'] = '武藤兰'
print('打印增加后的：  info = ',info)
# 修改
print(info['stu1104'])
print('修改武藤兰为wutenglan')
info['stu1104'] = 'wutenglan'
print('修改后的: ',info['stu1104'])
print('完整的info数据：',info)

# 查找
'stu1101' in info       # 标准用法
info.get('stu1101')     # 获取数据，不存在的时候，返回None，不会报错
info['stu1101']         # 获取数据，不存在的时候，会报错

# 删除
info.pop('stu1104')     # 删除'stu1104'并返回该值
info.popitem()          # 随机删除数据，并返回该值
# del info[1489]          # 删除数据,1489为数字类型的键，其他的需要使用引号

# 多级字典的嵌套
av_catalog = {
	"欧美":{
		"www.youporn.com":["很多免费的，世界最大的","质量一般"],
		"www.pornpub.com":["很多免费的，也很大","质量比youporn高点"],
		"letmedothistoyou.com":["多少是自拍，高质量图片很多","资源不多，更新慢"],
		"x-art.com":["质量很高，真的很高","全部收费，屌丝请饶过"]
	},
	"日韩":{
		"tokyo-hot":["质量怎么样不清楚，个人已经不喜欢日韩范了","听说是收费的"]
	},
	"大陆":{
		"1024":["全部免费，真好,好人一生平安","服务器在国外,慢"]
	}
}
av_catalog["大陆"]["1024"][1] += ",可以用爬虫爬下来"  #   修改
print(av_catalog["大陆"]["1024"])
# output
# ["全部免费,真好,好人一生平安","服务器在国外，慢，可以用爬虫爬下来"]

# 字典的循环
# 只打印key
for k  in av_catalog:
	print('av_catalog keys: ',k)
	
# 打印key和值
for k2 in av_catalog:
	print('av_catalog keys-values:',k2,av_catalog[k2])


