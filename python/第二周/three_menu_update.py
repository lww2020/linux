#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
data = {
    '北京': {
        "昌平": {
            "沙河": ["oldboy", "ruijia"],
            "天通苑": ["lianjia", "woaiwojia"]
        },
        "朝阳": {
            "望京": ["奔驰", "陌陌"],
            "国贸": ["CICC", "HP"],
            "东直门": ["Advent", "飞信"]
        }
    },
    '山东': {
        "德州": {...},
        "青岛": {...},
        "济南": {...}
    },
    '广东': {
        "东莞": {...},
        "常数": {...},
        "佛山": {...}
    }
}
exit_flag = False
while not exit_flag:
    for i in data:
        print(i)
    choice = input("选择进入1级菜单,按b返回,q退出>>： ")
    if choice in data:
        while not exit_flag:
            for i2 in data[choice]:
                print('\t', i2)
            choice2 = input("选择进入2级菜单,按b返回,q退出>>： ")
            if choice2 in data[choice]:
                while not exit_flag:
                    for i3 in data[choice][choice2]:
                        print('\t\t', i3)
                    choice3 = input("选择进入3级菜单,按b返回,q退出>>: ")
                    if choice3 in data[choice][choice2]:
                        for i4 in data[choice][choice2][choice3]:
                            print(i4)
                        choice4 = input("最后一层，按b返回,q退出>>: ")
                        if choice4 == "b":
                            pass
                        elif choice4 == "q":
                            exit_flag = True
                    if choice3 == "b":
                        break
                    elif choice3 == "q":
                        exit_flag = True
                    elif choice3 not in data[choice][choice2]:
                        print("输入有误，请重新选择")
            if choice2 == 'b':
                break
            elif choice2 == 'q':
                exit_flag = True
            if choice2 not in data[choice]:     
                print("输入有误，请重新选择")            
    if choice == 'b':
        break
    else:
        if choice == "q":
            exit_flag = True
    if choice not in data:
        print("输入有误，请重新选择")