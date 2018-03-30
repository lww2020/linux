#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
功能要求：
1、启动程序后，输入用户名密码后，让用户输入工资，然后打印商品列表
2、允许用户根据商品编号购买商品
3、用户选择商品后，检测余额是否够，够就直接扣款，不够就提醒
4、可随时退出，退出时，打印已购买商品和余额
5、在用户使用过程中，
关键输出，如余额，商品已加入购物车等消息，需高亮显示
"""
product_list = [
{"name":"电脑","price": 1999},
{"name":"鼠标","price": 10},
{"name":"游艇","price": 20},
{"name":"美女","price": 998},
{"name":"watch","price":10600},
{"name":"iphone","price":8800},
{"name":"mac pro","price":14000}
]
shopping_list = []
username = 'davie'
password= 'davie123'
user_info = {"username":"davie","password":"davie123","salary":30000}
print("----------欢迎登陆----------")
_username = input("请输入您的用户名: ").strip()
_password = input("请输入您的密码: ").strip()
if _username == user_info["username"] and _password == user_info["password"]:
	salary = input("请输入你的薪资: ").strip()
	if salary.isdigit():
		salary = int(salary)
		while True:
			print("---------商品列表--开始------------")
			for idx, item in enumerate(product_list):
				print(idx, item)
			print("---------商品列表--结束------------")
			user_choice = input("请输入选择商品编号,输入q退出: ")
			if user_choice.isdigit():
				user_choice = int(user_choice)
				if user_choice >=0  and user_choice<len(product_list):
					p_item = product_list[user_choice]
					if p_item["price"] <= salary:
						shopping_list.append(p_item)
						salary -= p_item["price"]
						print("已经将%s添加到您的购物车了,你的余额是 \033[0;31m%s\033[0m元"%(p_item,salary))
					else:
						print("你的余额还剩下: \033[31m%s\033[0m元; 无法购买:%s; "%(salary,p_item),'还差: \033[0;31m%s\033[0m元'%(p_item["price"]-salary))
				else:
					print("\033[31m你选择的商品不存在!\033[0m,请重新选择: ")
					if user_choice == "q" or user_choice == "Q":
						print("\033[31m你选择了退出...\033[0m")
						print("------------\033[34m你已经购买了如下商品-开始\033[0m-------------")
						for idx, shopping_good in enumerate(shopping_list):
							print(idx, shopping_good)
						print("你当前的余额为：\033[36m%s元\033[0m" % (salary))
						print("------------\033[34m你已经购买了如上商品-结束\033[0m-------------")
						exit("已结束...")
			elif user_choice == "q" or user_choice == "Q":
				print("\033[31m你选择了退出...\033[0m")
				print("------------\033[34m你已经购买了如下商品-开始\033[0m-------------")
				for idx, shopping_good in enumerate(shopping_list):
					print(idx, shopping_good)
				print("你当前的余额为：\033[36m%s元\033[0m" % (salary))
				print("------------\033[34m你已经购买了如上商品-结束\033[0m-------------")
				exit("已结束...")
			else:
				print("你输入的参数无效,已结束!")
				print("------------\033[34m你已经购买了如下商品-开始\033[0m-------------")
				for idx, shopping_good in enumerate(shopping_list):
					print(idx, shopping_good)
				print("你当前的余额为：\033[36m%s元\033[0m" % (salary))
				print("------------\033[34m你已经购买了如上商品-结束\033[0m-------------")
				break
else:
	print("\033[0;31m对不起，登陆失败！\033[0m")