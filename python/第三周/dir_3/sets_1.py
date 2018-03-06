#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
1、集合
主要作用：
	1、去重
	2、关系测试，交集\差集\并集\反向(对称)差集
"""
C:\Users\User\AppData\Local\Programs\Python\Python36\python.exe "C:\Program Files\JetBrains\PyCharm 2017.1.3\helpers\pydev\pydevconsole.py" 59804 59805
PyDev console: starting.

import sys; print('Python %s on %s' % (sys.version, sys.platform))
sys.path.extend(['D:\\SHELL\\python', 'D:/SHELL/python'])

Python 3.6.1 (v3.6.1:69c0db5, Mar 21 2017, 18:41:36) [MSC v.1900 64 bit (AMD64)] on win32
>>> a = {1,2,3,4}
>>> b = {3,4,5,6}
>>> a
{1, 2, 3, 4}
>>> type(a)
<class 'set'>
>>> a.symmetric_difference(b)
{1, 2, 5, 6}
>>>
>>> a.difference(b)
{1, 2}
>>> a.union(b)
{1, 2, 3, 4, 5, 6}
>>> a.issubset(b)
False

