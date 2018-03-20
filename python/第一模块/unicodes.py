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

