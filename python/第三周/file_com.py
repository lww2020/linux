#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
import sys
f = open("yesterday.py","r",encoding="utf-8")
f_new = open("yesterday.bak","w",encoding="utf-8")
find_str = sys.argv[1]
replace_str = sys.argv[2]
for line in f:
	if "开心" in line:
		line = line.replace(sys.argv[1],sys.argv[2])
	f_new .write(line)
f.close()
f_new.close()