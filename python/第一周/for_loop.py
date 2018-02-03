# -*- coding:utf-8 -*-
# Author: davie
#  这里设置为12 ，是因为有3次需要选择输入y|n, 12-3等于9，然后将count = -1,
#+ 才共计有效次数为10.
count = 0
age = 23
for i in range(12):
    if count <3:
        guess_age = int(input("请输入你猜的年龄: "))
        if guess_age == age:
            print("恭喜你，猜对了")
            break
        elif guess_age > age:
            print("你猜的年龄比实际大了")
        else:
            print("你猜的年龄比实际小了")
    else:
        choice = input("你已经连续三次猜错了，是否继续？请选择：y|n: ")
        if choice == "Y" or choice == "y":
            count = -1
        elif choice == "N" or choice =="n":
            print("结束")
            break
        else:
            print("你输入的有误！")
    count += 1
else:
    print("共计输入错误次数超过10次")