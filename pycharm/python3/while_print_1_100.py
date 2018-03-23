#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
 1. 使用 while 循环实现输出 1,2,3,4,5, 7,8,9, 11,12
 2. 使用 while 循环实现输出 1-100 内的所有奇数
'''

# a. 使用 while 循环实现输出 1,2,3,4,5, 7,8,9, 11,12
count = 0
while count < 12:
    count += 1
    if count == 10:
        continue
    print(count)
print("----------1,2,3,4,5, 7,8,9, 11,12-------------")
# b. 使用 while 循环实现输出 1-100 内的所有奇数
count = 0
while count < 100:
    count += 1
    if count % 2 != 0:
        print(count)
print("----------1-100之间的奇数-------------")
# c. 使用 while 循环实现输出 1-100 内的所有偶数
count = 0
while count < 100:
    count += 1
    if count % 2 == 0:
        print(count)
print("----------1-100之间的偶数-------------")
