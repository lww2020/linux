#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
13 、现有商品列表如下:
products = [['Iphone8',6888],['MacPro',14800],['小米6',2499],['Coffee',31],['Book',80],['Nike Shoes',799]]
需要打印出这样的格式：
---------商品列表----------
0、Iphone8       6888
1、MacPro        14800
2、小米          2499
3、Coffee        31
4、Book          80
5、Nike Shoes    799
"""
products = [['Iphone8',6888],['MacPro',14800],['小米6',2499],['Coffee',31],['Book',80],['Nike Shoes',799]]
print('---------商品列表----------')
for idx,p in enumerate(products):
	#print(idx,'、',p[0],' ',p[1])
	print('%s、 %s  %s' % (idx,p[0],p[1]))
"""
14、写一个循环，不断的问用户想买什么，用户选择一个商品编号，
就把相应的商品添加到购物车里，最终用户输入q时，打印购物车里的
商品列表
"""
products = [['Iphone8', 6888], ['MacPro', 14800], ['小米6', 2499], ['Coffee', 31], ['Book', 80], ['Nike Shoes', 799]]
shopping_cart = []
exit_flag = False   # 标志位
while not exit_flag:
	print('---------商品列表----------')
	for idx,p in enumerate(products):
		print('%s、 %s %s' % (idx,p[0],p[1]))
	user_choice = input('请输入想购买的商品编号: ')
	if user_choice.isdigit():
		user_choice = int(user_choice)
		if user_choice >=0 and user_choice <len(products):
			shopping_cart.append(products[user_choice])
			print('Added product %s into shopping cart '% (products[user_choice]))
			print(shopping_cart)
		else:
			print("你所选择的商品编号不存在，请重新输入选择!")
	elif user_choice == 'q' or user_choice == 'Q':
		if len(shopping_cart) >0:
			print('----------你已经购买了如下商品: ----------')
			for index,bought_goods in enumerate(shopping_cart):
				print('%s、 %s %s' % (index,bought_goods[0],bought_goods[1]))
			exit_flag = True
	else:
		#exit_flag = True
		print('你输入的有误！')
		print('你本次没有购买任何商品,截止目前已经购物商品如下:')
		print(shopping_cart)
		exit_flag = True