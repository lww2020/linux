#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
products = [
	['Iphone8',6888],
	['Mac Pro',14800],
	['小米6',2499],
	['Coffee',31],
	['Book',80],
	['Nike',799]
	]
shopping_cart = []
exit_flag = False
while not exit_flag:
	print("---------商品列表-----------")
	for index,value in enumerate(products):
		print("%s. %s %s"%(index,value[0],value[1]))
	user_choice = input("输入想买的商品编号: ")
	if user_choice.isdigit():
		user_choice = int(user_choice)
		if user_choice >=0 and user_choice<len(products):
			shopping_cart.append(products[user_choice])
			print("Added product %s into shopping_acrt" %(products[user_choice]))
			print(products[user_choice])
		else:
			print("您输入编号，该商品不存在，请重新输入")
	elif user_choice == "q" or user_choice == "Q":
		print("---------已经购买商品列表-开始-----------")
		for index, value in enumerate(shopping_cart):
			print("%s. %s %s" % (index, value[0], value[1]))
		print("---------已经购买商品列表-结束-----------")
		exit_flag = True
	else:
		#print("输入有误,已退出!")
		if len(shopping_cart)>0:
			print("---------已经购买商品列表-开始-----------")
			for index, value in enumerate(shopping_cart):
				print("%s. %s %s" % (index, value[0], value[1]))
			print("---------已经购买商品列表-结束-----------")
		exit_flag = True
		