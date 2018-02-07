#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
name = "my name is alex"
name1 = "my \tname is alex"
intr_self = "My name is {name}, and I'am {age} years old this year!"
print(name.capitalize()) # 首字母大写，如上的结果会显示：Alex le
print(name.count("a")) # 统计给出的a总共有几个
print(name.center(50,"-")) # 宽度，填充字符，只能是单个字符
print(name.endswith("ex")) # 判断是否以ex结尾
print(name1.expandtabs(tabsize=30)) # 将tab转换成多少个空格
print(name.find("name")) # 找出所给值得索引
print(name[name.find("name"):]) # 先找出name的下标，然后截取到最后的所有值
print(intr_self.format(name="davie",age=23)) # 格式化输出
print(intr_self.format_map({"name":"davie","age":23})) # 格式化输出
print('ab1234'.isalnum()) # 阿拉伯数字和英文字母,结果为True
print('ascW'.isalpha()) # 纯英文字母，结果为True
print('1a'.isdecimal()) # 判断是否为十进制数，结果为False
print('1.0'.isdigit()) # 判断是否为整数,结果为False
print('-1A'.isidentifier()) # 判断是否为合法的标识符，结果为Fasle
print('a'.islower()) # 判断是否为小写，结果为True
print('22.A'.isnumeric()) # 判断是否为数字，和isdigital类似
print('My name is davie!'.istitle()) # 每个单词的首字母是否为大写，结果为False
print('My name is davie'.isupper()) # 判断是否都为大写
print('+'.join(["app","le","friut"])) # 用“+”把三个元素连接起来
print(name.ljust(50,'*')) # 从左边开始计算，不到50字符，那么就在右边填充*
print(name.rjust(50,'*')) # 从右边开始计算，不到50字符，那么就在左边填充*
print('Davie'.lower()) #  变成小写
print('Davie'.upper()) # 变成大写
print('     davie is a good man!'.lstrip()) # 去掉左边的空格
print('  davie is a good man!    '.rstrip()) # 去掉右边的空格
print('  davie is     a good man!   '.strip()) #  去掉两边的空格
p = str.maketrans('abcdef','123abc') # 转换成对应的字符
print(p)
print("alex".translate(p)) # 反转义
print("alex li".replace('l','L',1)) # 将第一个l替换成L
print("alex lil".rfind('l')) #  从左边往右找，找到最右边的那个l的下标
print('al ex lil'.split()) # 默认按照空格将其隔开成列表
print('al ex lil'.split('l')) # 用l做分隔符，将剩余的字符串作为列表划分
print('aLeX iL'.swapcase()) #  大小写反转
print('davie is a young man'.title()) # 每个元素的首字母大写
print('davie is a young man'.capitalize())  # 只有第一个元素的首字母大写
print('davie'.zfill(10))

