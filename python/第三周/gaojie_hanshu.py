#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
def add(a,b,f):
	return f(a)+f(b)
res = add(3,-6,abs)
print(res)