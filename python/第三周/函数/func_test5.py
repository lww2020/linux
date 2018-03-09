#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
def test(x,y=2):
	print(x)
	print(y)
test(1,4)
test(1,y=5)
# 默认参数特点：函数调用的时候，默认参数非必须传递
