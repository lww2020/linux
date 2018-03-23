#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
假设一年期定期利率为3.25%，计算一下需要过多少年，一万元的一年定期存款连本带息能翻番？（编程题）
'''
rate = 0.0325
money = 10000
year = 0
while money <=20000:
    year += 1
    money = money*(1+rate)
print("%s年后,"%year,"一万元的连本带息能翻翻")
