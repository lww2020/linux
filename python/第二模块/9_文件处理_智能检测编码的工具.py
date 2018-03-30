#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
r VS rb
问：示例2和示例1的区别在哪？
答：在于示例2打开文件时，并未指定encoding,这是为何？是因为直接以
rb模式打开了文件，rb是指二进制模式，数据读到内存里直接是bytes格式，
如果想看内容，还需要手动decode，因此在文件打开阶段，不需要指定编码。
问：假如你不知道你要处理的文件是什么编码可怎么办了呢？
"""
import chardet
f = open(file='grils_info.txt',mode='rb')
data = f.read()
f.close()

result = chardet.detect(open(file='grils_info.txt',mode='rb'))
print(result)


"""
[root@db01 test]# python3
Python 3.6.4 (default, Jan 25 2018, 06:55:49)
[GCC 4.4.4 20100726 (Red Hat 4.4.4-13)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import chardet
>>> f = open(file='/root/test/girls_info.txt',mode='rb')
>>> data = f.read()
>>> data
b'\xe7\x8e\x8b\xe5\xbf\x83\xe9\xa2\x9c \xe4\xb8\x8a\xe6\xb5\xb7  169 46  13813234424\n\xe9\xa9\xac\xe7\xba\xa4\xe7\xbe\xbd \xe6\xb7\xb1\xe5\x9c\xb3  173 50  13744234523\n\xe4\xb9\x94\xe4\xba\xa6\xe8\x8f\xb2 \xe5\xb9\xbf\xe5\xb7\x9e  172 52  15823423525\n\xe7\xbd\x97\xe6\xa2\xa6\xe7\xab\xb9 \xe5\x8c\x97\xe4\xba\xac  175 49  18623423421\n\xe5\x88\x98\xe8\xaf\xba\xe6\xb6\xb5 \xe5\x8c\x97\xe4\xba\xac  170 48  18623423765\n\xe5\xb2\xb3\xe5\xa6\xae\xe5\xa6\xae \xe6\xb7\xb1\xe5\x9c\xb3  177 54  18835324553\n\xe8\xb4\xba\xe5\xa9\x89\xe8\x90\xb1 \xe6\xb7\xb1\xe5\x9c\xb3  174 52  18933434452\n\xe5\x8f\xb6\xe6\xa2\x93\xe8\x90\xb1 \xe4\xb8\x8a\xe6\xb5\xb7  171 49  18042432324\n\xe6\x9d\x9c\xe5\xa7\x97\xe5\xa7\x97 \xe5\x8c\x97\xe4\xba\xac  167 49  13324523342\n\xe9\xbb\x91\xe5\xa7\x91\xe5\xa8\x98 \xe6\xb2\xb3\xe5\x8c\x97  167 50  13542342233\n'
>>> charder.detect(data)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'charder' is not defined
>>> chardet.detect(data)
{'encoding': 'utf-8', 'confidence': 0.99, 'language': ''}
>>> data.decode(encoding="utf-8")
'王心颜 上海  169 46  13813234424\n马纤羽 深圳  173 50  13744234523\n乔亦菲 广州  172 52  15823423525\n罗梦竹 北京  175 49  18623423421\n刘诺涵 北京  170 48  18623423765\n岳妮妮 深圳  177 54  18835324553\n贺婉萱 深圳  174 52  18933434452\n叶梓萱 上海  171 49  18042432324\n杜姗姗 北京  167 49  13324523342\n黑姑娘 河北  167 50  13542342233\n'
>>> data.decode(encoding="utf-8").strip()
'王心颜 上海  169 46  13813234424\n马纤羽 深圳  173 50  13744234523\n乔亦菲 广州  172 52  15823423525\n罗梦竹 北京  175 49  18623423421\n刘诺涵 北京  170 48  18623423765\n岳妮妮 深圳  177 54  18835324553\n贺婉萱 深圳  174 52  18933434452\n叶梓萱 上海  171 49  18042432324\n杜姗姗 北京  167 49  13324523342\n黑姑娘 河北  167 50  13542342233'
>>> data.decode(encoding="utf-8")
'王心颜 上海  169 46  13813234424\n马纤羽 深圳  173 50  13744234523\n乔亦菲 广州  172 52  15823423525\n罗梦竹 北京  175 49  18623423421\n刘诺涵 北京  170 48  18623423765\n岳妮妮 深圳  177 54  18835324553\n贺婉萱 深圳  174 52  18933434452\n叶梓萱 上海  171 49  18042432324\n杜姗姗 北京  167 49  13324523342\n黑姑娘 河北  167 50  13542342233\n'
>>>

"""