#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
import copy
name1 = ["ZhanYang","GuYun","XiangPeng",["davie","jack"],"XuLiangChen","GuYun"]
name2 = copy.deepcopy(name1)
print(name1)
print(name2)

name1[(name1.index(["davie","jack"]))]=["Dave","Jack"]
print("修改后的数据：")
print(name1)
print(name2)
