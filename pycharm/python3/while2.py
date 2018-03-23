#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
count = 0
while count <= 100 : # 只要count<=20就不断执行下面的代码
    count += 1
    if count > 5 and count < 95:
        continue
    print("loop: ", count)
print("-------out of while loop ----------")
