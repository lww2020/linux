#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
name = input("请输入您的名字: ").strip()
age = int(input("请输入您的年龄: "))
job = input("请输入您的职业: ").strip()
hometown = input("请输入您的家乡: ").strip()
"""
# 1、
print("-----------info of {} begin--------------".format(name))
print("姓名: {}".format(name))
print("年龄: {}".format(age))
print("职业: {}".format(job))
print("家乡: {}".format(hometown))
print("-----------info of {} end----------------".format(name))
"""

# 2、
info = """
-------- info of %s begin------
Name:       %s
Age:        %s
Job:        %s
HomeTown:   %s
-------- info of %s end--------
""" % (name,name,age,job,hometown,name)
print(info)

# 4
msg = """
-------- info of {Name} begin------
Name:       {Name}
Age:        {Age}
Job:        {Job}
HomeTown:   {HomeTown}
-------- info of {Name} end--------
""".format(Name=name,Age=age,Job=job,HomeTown=hometown)
print(msg)
