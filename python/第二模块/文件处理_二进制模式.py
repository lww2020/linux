#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
f = open(file='girls_info.txt',mode='rb')
data = f.read().decode('gbk')
print(data)
f.close()
