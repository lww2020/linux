#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
程序：购物车程序
需求:
    启动程序后，让用户输入工资，然后打印商品列表
    允许用户根据商品编号购买商品
    用户选择商品后，检测余额是否够，够就直接扣款，不够就提醒
    可随时退出，退出时，打印已购买商品和余额
"""
products_list = [
['Iphone',5000],
['Mac Pro',9000],
['Bike',800],
['Watch',12000],
['book',89],
['HuaWei',6000],
['XiMi',2600]
]
salary = input("请输入你的薪资: ")
shopping_list = []
if salary.isdigit():
    salary = int(salary)
    while True:
        print("---------商品列表--开始------------")
        for idx,item in enumerate(products_list):
            print(idx,item)
        print("---------商品列表--结束------------")
        user_choice = input("请选择商品编号: ")
        if user_choice.isdigit():
            user_choice = int(user_choice)
            if user_choice >= 0 and user_choice < len(products_list):
                p_item = products_list[user_choice]
                if p_item[1] <= salary:
                    shopping_list.append(p_item)
                    salary -= p_item[1]
                    print("Added %s into shopping cart， \033[33myour balance is: %s元\033[0m" % (p_item,salary))
                else:
                    print("你的余额不足,只剩下: \033[31m%s元\033[0m." % (salary),'无法购买当前: %s' %(p_item))
                    break
            else:
                print("你选择的商品: \033[31m{}\033[0m 不存在!".format(user_choice))
        elif user_choice == "q" or user_choice == "Q":
            print("\033[31m你选择了退出...\033[0m")
            print("------------\033[34m你已经购买了如下商品-开始\033[0m-------------")
            for idx,shopping_good in enumerate(shopping_list):
                print(idx,shopping_good)
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
