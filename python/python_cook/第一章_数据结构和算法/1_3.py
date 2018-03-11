#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
3.3 1.3 保留最后N个元素
3.3.1 问题
	在迭代操作或者其他操作的时候，怎样只保留最后有限几个元素的历史记录？
3.3.2 解决方案
	保留有限历史记录正是collection.deque大显身手的时候。比如，下面的代码在
多行上面做简单的文本匹配，并只返回在前N行中匹配成功的行:
"""
from collections import deque
def search(lines, pattern, history=5):
	previous_lines = deque(maxlen=history)
	for i in lines:
		if pattern in lishi:
			yield lishi, previous_lines
		previous_lines.append(lishi)
		
# Example use on a file
# if __name__ == '__main__':
# 	with open(r'../../cookbook/somefile.txt',encoding="utf-8") as f:
# 		for line, prevlines in search(f,'python',5):
# 			for pline in prevlines:
# 				print(pline,end="")
# 			print(line,end="")
# 			print("-"*20)
"""
3.3.3 讨论
	我们在写查询元素的代码时，通常会使用包含yild表达式的生成器函数，也就是我们上面
示例代码中的那样。这样可以将搜索过程代码和使用搜索结果代码解耦。
	使用deque(maxlen=N)构造函数会新建一个固定大小的队列。当心的元素加入并且这个队列
已满的时候，最老的元素会自动被移除。
"""
q = deque(maxlen=3)
print(q.append(1))
print(q.append(2))
print(q.append(3))
print(q.append(4))
print("p = ",q)
print(q.append(5))
print("p = ",q)
"""
	尽管你也可以手动在一个列表上实现这一操作(比如增加、删除等等)。但是这里的
队列方案更加优雅并且运行的更快些。
	更一般的，deque类可以被用在任何你只需要一个简单队列数据结构的场合。如果
你不设置最大队列大小，那么就会得到一个无限大小队列，你可以在队列的两端执行添加
和弹出元素的操作。
"""
p = deque()
print(p.append(1))
print(p.append(2))
print(p.append(3))
print("p = ",p)
print("p.appendleft: ",p.appendleft(4))
print("p.pop(): ",p.pop())
print("p = ",p)
print("p.popleft = ",p.popleft())
#  在队列两端插入或删除元素时间复杂度都是O(1)，而在列表的开头插入或删除元
#+ 素的时间复杂度为O(N)。


