#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
3.5 1.5 实现一个优先级队列
3.5.1 问题
	怎样实现一个按优先级排序的队列？并且在这个队列上面每次pop操作总是返回
优先级最高的那个元素
3.5.2 解决方案
	下面的类利用heapq模块实现了一个简单的优先级队列：
"""
import heapq
class PriorityQueue:
	def __init__(self):
		self._queue = []
		self._index = 0
		