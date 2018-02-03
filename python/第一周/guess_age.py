# -*- coding:utf-8 -*-
# Author: davie

age_of_girl = 56
guess_age = int(input("请输入你所猜的年龄: "))

if guess_age == age_of_girl:
    print("恭喜你，猜对了 .")
elif guess_age > age_of_girl:
    print("你猜的年龄数字比实际的大了")
else:
    print("你猜的年龄数字比实际的小了")