#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
制作趣味模板程序（编程题）
需求：等待用户输入名字、地点、爱好，根据用户的名字和爱好进行任意显示
如：敬爱可爱的xxx，最喜欢在xxx地方干xxx
'''
name = input("名字->: ")
address = input("地点->: ")
hobby = input("爱好->: ")
things = '''
敬爱可爱的{0},最喜欢在{1}地方干{2}
'''.format(name,address,hobby)
print(things)
