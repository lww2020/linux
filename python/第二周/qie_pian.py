#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# 切片：取多个元素
names = ["Alex","Tenglan","Eric","Rain","Tom","Amy"]
names[1:4] # 取下标1至下标4之间的数字，包括1，不包括4
names[1:-1] # 取下标1至-1的值，不包括-1
names[0:3]
names[:3] # 如果是从头开始取，0可以忽略，跟上句效果一样
names[3:] # 如果想取到最后一个，必须不能写-1，只能这么写
names[3:-1] # 这样-1就不会被包含了
names[0::2] # 后面的2是代表，每隔一个元素，就取一个
names[::2] # 和上面的效果一样

# 追加
names
names.append("Tony")
names

# 插入
names
names.insert(2,"Eric2")
names
names.insert(5,"Eric3")
names

# 修改
names
names[2]
names[2]="Eric2x"
names[2]

# 删除
names
del names[2]
names
names[4]
del names[4]
names
names[4]
names
names.remove("Eric") # 删除指定元素
names
names.pop() # 删除列表最后一个值
names

# 扩展
names
b = [1,2,3]
names.extend(b)
names

# 拷贝
names
names_copy = names.copy()
names_copy

# 统计
names
names.append("Amy")
names.count("Amy")

# 排序&翻转
names
names.sort() # 排序
names[-3] = "1"
names[-2] = "2"
names[-1] = "3"
names
names.sort()
names.reverse()
names

# 获取下标
names
names.index("Amy") # 只返回找到的第一个下标

# 元组
'''
元组其实跟列表差不多，也是存一组数据，只不过它是一旦创建，便不能再修改，所以又叫只读列表。
语法：
names = ("alex","jack","eric")
 它只有2个方法，一个是count，一个是index。
'''
names = ("alex","jack","eric")
names = ("alex","jack","eric","alex")
names.count("alex")
names.index("jack")

