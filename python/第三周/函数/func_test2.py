#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
import time
def logger():
	time_format = '%Y-%m-%d %X'
	time_current = time.strftime(time_format)
	with open('a.txt', 'ab',encoding="utf-8") as f:
		f.write('%s end action \n' % (time_current))
def test1():
	print("test1 start action...")
	logger()
def test2():
	print("test2 start action...")
	logger()
def test3():
	print("test3 start action...")
	logger()