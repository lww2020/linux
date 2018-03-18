#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
n2 = ['Shanshan', 'Longting', 'Alex', 1,3,4,5,6,7,7,8,8,9,9,0,0,2,2,4,4]

# 删除
n2.pop()            # 不指定,就删除最后一个元素
n2.pop(1)           # 删除下标为1的元素
n2.remove("abc")    # 直接指定需要删除的元素，只能删除单个元素
n2.remove(4)        # 删除数字4这个元素，只能删除单个元素
del n2[2]           # 通用删除方法，删除下标为2的元素
del n2[2:6]         # 可以批量删除
