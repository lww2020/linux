#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
x = 0
def grandpa():
	def dad():  # x = 1
		x = 2
		def son():
			x = 3
			print(x)
		son()
	dad()
grandpa()
