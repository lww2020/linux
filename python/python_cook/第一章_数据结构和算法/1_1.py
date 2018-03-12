#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
3.1
1.1 解压序列赋值给多个变量
3.1.1 问题
	现在有一个包含N个元素的元组或者是序列，怎样将它里面的值解压后同时赋值
	给N个变量？
3.1.2 解决方案
	任何的序列(或者是可迭代对象)可以通过一个简单的赋值语句解压并赋值给多个
	变量。唯一的前提就是变量的数量必须跟序列元素的数量是一样的。
"""
# 元组
p = (4,5)
x,y = p
print("x = ",x)
print("y = ",y)

# 列表
data = ['ACME',50,91.1,(2012,12,21)]
name,shares,price,date = data
print("name = ",name)
print("date = ",date)

name,shares,price,(year,mon,day) = data
print("name = ",name)
print("year = ",year)
print("mon = ",mon)
print("day =",day)

# 如果变量个数和序列元素的个数不匹配，会产生一个异常。

"""
3.1.3 讨论
	实际上，这种解压赋值可以用在任何可迭代对象上面，而不仅仅是列表或者元组。
	包括字符串，文件对象，迭代器和生成器。
"""
s = "hello"
a,b,c,d,e = s
print("a = ",a)
print("b = ",b)
print("e = ",e)

"""
有时候，你可能只想解压一部分，丢弃其他的值。对于这种情况Python并没有提
供特殊的语法。但是你可以使用任意变量名去占位，到时候丢掉这些变量就行了。
"""
data = ['ACME',50,91.1,(2012,12,21)]
_,shares,price,_ = data
print("shares = ",shares)
print("prince = ",price)
# 你必须保证那些占位变量名没有在其他地方没有被占用