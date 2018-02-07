#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
info = {
    'stu1101':"a",
    'stu1102':'b',
    'stu1103':'c'
}
b = {
    'stu1101':"daie",
    "1":3,
    "2":5
}
'''
#info.update(b)
#print(info)
c = dict.fromkeys([6,7,8],['test',{"name":"jing"},44])
print(c)
c[7][1]['name'] = "hon"
print(c)
#print(info.items())
'''
# 字典循环
# 这种效率高
print(info)
for i in info:
    print(i,info[i])

# 这种效率低
for k,v in info.items():
    print(k,v)