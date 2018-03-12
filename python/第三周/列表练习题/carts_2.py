#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
products = [['Iphone8', 6888], ['MacPro', 14800], ['小米6', 2499], ['Coffee', 31], ['Book', 80], ['Nike Shoes', 799]]
shopping_cart = []
exit_flag = False   # 标志位
while not exit_flag:
	print('---------商品列表----------')
	for index,p in enumerate(products):
		print("%s、 %s %s" % (index,p[0],p[1] ))
	choice = input(" 输入想购买的商品编号: ")
	if choice.isdigit():
		choice = int(choice)
		if choice >=0 and choice < len(products):
			shopping_cart.append(products[choice])
			print("Added product %s into shopping cart" % (products[choice]))
		else:
			print("商品不存在")
	elif choice == 'q':
		if len(shopping_cart) >0:
			print("---------- 你已经购买了如下商品----------")
			for index, p in enumerate(shopping_cart):
				print("%s、 %s %s" % (index, p[0], p[1]))
		else:
			exit_flag = True
	else:
		print(" 你本次输入了非商品编号或者选择退出,购买过程结束！")
		print("---------- 截止目前,你已经购买了如下商品----------")
		for index, p in enumerate(shopping_cart):
			print("%s、 %s %s" % (index, p[0], p[1]))
		exit_flag = True