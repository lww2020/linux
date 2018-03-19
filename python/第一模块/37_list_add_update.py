#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
n2 = ['Shanshan', 'Longting', 'Alex', 1,3,4,5,6,7,7,8,8,9,9,0,0,2,2,4,4]
print('n2: ',n2)
n2.append("Wupeixi")
print('n2.append("wupeixi"): ',n2)
n2.insert(0,'abc')
print("n2.insert(0,'abc'): ",n2)
n2.insert(2,'Alex')
print('n2 = ',n2)
# 修改
n2[2] = 'Peiqi'
print("n2 = ",n2)
n2[4:6] = ['JACK LIU']
print("n2 = ",n2)