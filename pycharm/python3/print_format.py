#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
'''
练习：用户输入姓名、年龄、工作、爱好 ，然后打印成以下格式
------------ info of Egon -----------
Name : Egon
Age : 22
Sex : male
Job : Teacher
------------- end -----------------
'''

name = input("姓名->:")
age = input("年龄->:")
sex = input("性别->:")
job = input("工作->:")
info = '''
------------ info of %s -----------
Name : %s
Age :  %s
Sex :  %s
Job :  %s
------------- end -----------------
'''%(name,name,age,sex,job)

print(info)