#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# age_of_oldboy = 56
# if age_of_oldboy >57:
# 	print("Too old, time to retire!")
# else:
# 	print("还能折腾几年")

# _username = "shanshan"
# _password = "abc123"
# username = input("请输入用户名: ").strip()
# password = input("请输入密码: ")
#
# if _username == username  and _password == password:
# 	print("welcome ",_username)
# else:
# 	print("wrong username or password!")

#  练习1：输入姓名、性别、判断如果是女生，打印我喜欢女生，
#+ 否则，打印一起来搞基！
# _username = input("请输入你的姓名: ")
# _sex = 'f'
# sex = input("请输入你的性别f/m: ")
# if sex == _sex or sex == "F":
# 	print("我喜欢女生")
# else:
# 	print("一起来搞基")
#
# #  练习2：输入姓名，性别，年龄，判断如果是女生且年龄小于28岁
# #+ 打印我喜欢女生，否则，打印姐弟恋也很好哦
# _username = input("请输入姓名: ").strip()
# _sex = input("请输入性别f/m: ").strip()
# _age = int(input("请输入年龄: "))
# if _sex == "f" and _age < 28:
# 	print("我喜欢女生！")
# else:
# 	print("姐弟恋也很好奥！")

#  练习3：输入姓名、性别、年龄，判断如果是女生且年龄小于28岁，打印
#+ 我喜欢女生，否则打印姐弟恋也很好哦！如果是男生，打印一起来搞基！
_name = input("请输入姓名: ").strip()
_sex = input("请输入性别f/m: ").strip()
_age = int(input("请输入年龄: "))
if _sex == "f" and _age < 28:
	print("我喜欢女生!")
elif _sex == "f" and _age >= 28:
	print("姐弟恋也很好哦!")
elif _sex == "m" or _sex == "M":
	print("一起来搞基!")
else:
	print("输入有误!")
