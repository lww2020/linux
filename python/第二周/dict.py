#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# [1:3]:  左闭右开，顾头不顾尾
names = ["ZhanYang","GuYun","XiangPeng","XuLiangChen","GuYun"]
#print(names)
#print(names[0],',',names[2])
#print(names[1:3])
#print(names[0:3])
#print(names[-2:])
#print(names[:3])
#names.append("LeiHaiDong")
#names.insert(1,"ChenRongHua")
#names.insert(3,"XinZhiYu")
#names[2] = "XieDi"

# delete
#names.remove("ChenZhongHua")
#del names[1]
#names.pop(1)
#print(names.index("XiangPeng"))
#print(names.count("GuYun"))
#names.clear()
print(names)
names.reverse()
names.sort()
print(names)
names2 = [1,2,3,4]
names.extend(names2)
del names2
print(names)