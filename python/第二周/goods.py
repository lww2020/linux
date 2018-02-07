# -*- coding:utf-8 -*-
# Author: davie
'''
程序：购物车程序
需求:
    启动程序后，让用户输入工资，然后打印商品列表
    允许用户根据商品编号购买商品
    用户选择商品后，检测余额是否够，够就直接扣款，不够就提醒
    可随时退出，退出时，打印已购买商品和余额
'''
product_list = [
    ['Iphone',5000],
    ['Mac Pro',9800],
    ['Bike',800],
    ['Watch',10600],
    ['Coffee',31],
    ['Alex Python',120]
]
salary = input("请输入你的薪资: ")
shopping_list = []
if salary.isdigit():
    salary = int(salary)
    while True:
        for index,item in enumerate(product_list):
            print(index ,item)
        user_choice = input("请选择商品的编号: ")
        if user_choice.isdigit():
            user_choice = int(user_choice)
            if user_choice >=0 and user_choice <= len(product_list):
                p_item = product_list[user_choice]
                if p_item[1] <= salary: # 买的起
                    shopping_list.append(p_item)
                    salary -= p_item[1]
                    print("Added %s into shopping cart, your  current blance is: \033[31;1m%s \033[0m元;" % (p_item,salary))
                else:
                    print("\033[41;1m您的余额不足，只剩下%s元." % (salary),'无法购买当前: %s商品!\033[0m' % (p_item) )
            else:
                print("你选择商品{}不存在！".format(user_choice))
        elif user_choice == "q" or user_choice == "Q":
                print("-----已经购买了如下商品_begin-----")
                for i,p_good in enumerate(shopping_list):
                    print(i,p_good)
                print("您目前的余额为：%s" % (salary) )
                print("-----已经购买了以上商品_end-----")
                exit()
        else:
            print("你输入的值无效！")
