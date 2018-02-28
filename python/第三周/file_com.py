#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
f = open("yesterday.py","r",encoding="utf-8")
f_new = open("yesterday.bak","w",encoding="utf-8")
for line in f:
	if "开心" in line:
		line = line.replace("开心","快快乐乐!")
	f_new .write(line)
f.close()
f_new.close()