#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
使用while循环实现输出2-3+4-5+6...+100 的和
"""
res = 2
count = 3
while count <= 100:
    if count%2 == 0:
        res += count
    else:
        res -= count
    count += 1
print(res)
