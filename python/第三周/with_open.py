#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
import sys
with open("yesterday.py","r",encoding="utf-8") as f,\
     open("yesterday.py2","r",encoding="utf-8") as f2:
	for line in f:
		print(f.readline().strip())
		
