#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# 默认参数特点：调用函数时，默认参数非必传递
#  用途：
# 1、默认值
def test(x,y=2):
	print(x)
	print(y)
test(1,3)