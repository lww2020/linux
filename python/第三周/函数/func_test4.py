#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
def test(x,y):
	print(x)
	print(y)
test(1,3)       # 与形参顺序一一对应
test(y=1,x=3)   # 与形参顺序无关
test(2,y=4)     # 位置参数在先，形参在后，正常显示
test(y=3,4)     # 关键参数在先，位置参数在后，报错