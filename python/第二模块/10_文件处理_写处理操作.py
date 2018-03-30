#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
循环文件
为什么每行之间有空行？

girls_info.txt的内容
王心颜 上海  169 46  13813234424
马纤羽 深圳  173 50  13744234523
乔亦菲 广州  172 52  15823423525
罗梦竹 北京  175 49  18623423421
刘诺涵 北京  170 48  18623423765
岳妮妮 深圳  177 54  18835324553
贺婉萱 深圳  174 52  18933434452
叶梓萱 上海  171 49  18042432324
杜姗姗 北京  167 49  13324523342
黑姑娘 河北  167 50  13542342233
"""
# f = open(file='girls_info.txt',mode='r',encoding='gbk')
# for line in f:
# 	#print(line)
# 	print(line.strip())
# f.close()

# 写文件，w会新建一个文件
f = open(file='girls2_info.txt',mode='r+',encoding='utf-8')
data = f.write('北大本科美国留学一次5w，微信号:xxxxx\n')
f.close()

