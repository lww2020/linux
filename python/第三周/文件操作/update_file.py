#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
f = open("yesterday2",'r',encoding="utf-8")
f_new = open("yesterday2.bak",'w',encoding="utf-8")
for line in f:
	if "当我轻狂年少" in line:
		line = line.replace('当我轻狂年少','当我轻狂年少的时候')
	f_new.write(line)
f.close()
f_new.close()