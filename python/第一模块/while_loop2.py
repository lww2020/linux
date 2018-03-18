#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# 打印0到10之间的数，当等于5时。不打印，6到8之间，打印它的平方值
count = 0
while count < 10:
    if count == 5:
        pass
    elif count>=6 and count<=8:
        print("{}的平方 = ".format(count),count*count)
    else:
        print("loop: ",count)
    count += 1

# 打印偶数
count = 0
while count < 10:
    if (count % 2) == 0:
        print("loop: ",count)
    count += 1

# 打印0到100的偶数
i = 0
while i < 100:
    print("current loop {}".format(i))
    i += 1
