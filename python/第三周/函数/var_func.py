#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# school = "old_boy edu"
# names = ["Alex","Jack","Rain"]
# def change_name(name):
# 	names[0] = "金角大王"
# 	print('inside func:',names)
# change_name(names)
def calc(n):
	print(n)
	if int(n/2) > 0:
		return calc(int(n/2))
	print("-->",n)
calc(10)
