#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
decode(解码)
encode(编码)

UTF-8--> decode 解码--> Unicode
Unicode-->encode 编码--> if GBK / UTF-8 ...

s = "路飞学城"
s2 = s.decode("utf-8")
print(type(s2))

s3 = s2.encode("gbk")
s4 = s2.encode("utf-8")
print(s3)
print(s4)

提示：Python只要出现各种编码问题，无非是哪里的编码设置出错了
常见编码错误的原因有：
1、Python解释器的默认编码
2、Python源文件编码
3、Terminal使用的编码
4、操作系统的语言设置

