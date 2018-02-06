# -*- coding:utf-8 -*-
# Author: davie
count = 0
age_of_davie = 23
while count < 3:
    count += 1
    guess_age = int(input("请输入你猜的年龄: "))
    if guess_age == 23:
        print("恭喜你，猜对了")
        break
    #    continue
    elif guess_age > 23:
        print("你猜的年龄比实际的大，请下次猜小一点的年龄")
    else:
        print("你猜的年龄比实际的小，请下次猜大一点的年龄")
    if count == 3:
        choice = input("你已经连续3次猜错，还继续猜吗?请选择：Y|N")
        if choice == "Y" or choice == "y":
            count = 0