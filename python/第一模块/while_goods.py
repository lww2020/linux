#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
14、写一个循环，不断的问用户想买什么，用户选择一个商品编号，
就把对应的商品添加到购物车里，最终用户输入q退出时，打印
购物车里的商品。
"""
products = [['Iphone8',6888],['Mac Pro',14800],['小米6',2499],['Coffee',31],['Book',80],['Nike',799]]
shopping_cart = []
EXIT_FLAG = False


while not EXIT_FLAG :
	print('---------商品列表----------')
	for idx, p in enumerate(products):
		print('%s. %s %s' % (idx, p[0], p[1]))
	print("-----商品列表-结束-----")
	choice = input("请输入您要购买的商品编号(q退出): ")
	if choice.isdigit():
		choice = int(choice)
		if choice >=0 and choice<len(products):
			shopping_cart.append(products[choice])
			print("您已经将%s加入到了购物车."%(products[choice]))
			print("-----您目前已经购买了如下商品-开始-----")
			print(shopping_cart)
			print("-----您目前已经购买了如上商品-结束-----")
		else:
			print("你所选择的商品编号不存在，请重新输入选择!")
	elif choice == "q" or choice == "Q":
		print("您已经选择退出!")
		if len(shopping_cart)>0:
			print('----------你已经购买了如下商品-开始 ----------')
			for index,value in enumerate(shopping_cart):
				print("{0}. {1} {2}".format(index,value[0],value[1]))
			print('----------你已经购买了如上商品-结束 ----------')
		EXIT_FLAG = True
	else:
		print("您本次输入的有误!")
		if len(shopping_cart)>0:
			print('----------你已经购买了如下商品-开始 ----------')
			for index,value in enumerate(shopping_cart):
				print("{0}. {1} {2}".format(index,value[0],value[1]))
			print('----------你已经购买了如上商品-结束 ----------')
		EXIT_FLAG = True