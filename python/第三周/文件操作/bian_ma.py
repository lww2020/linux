#!/usr/bin/env python3
# -*- coding:gbk -*-
# Author: davie
import sys
print(sys.getdefaultencoding())
s = "你哈"  # unicode编码
print('s_gbk: ',s.encode("gbk"))
print('s_utf-8: ',s.encode("utf-8"))
print('s_gb2312: ',s.encode("utf-8").decode("utf-8").encode("gb2312").decode("gb2312"))
print("s_gbk_utf-8: ",s.encode("gbk").decode("gbk"))
