#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie

# if
# spam = 0
# if spam < 5:
#     print("Hello, world.")
#     spam = spam + 1

# while
# spam = 0
# while spam < 5:
#     spam = spam + 1
#     print("Hello, world. loop: %s."%spam)
#

# while True:
#     print("Please type your name.")
#     name = input("请输入用户名->: ")
#     if name == 'davie':
#         break
# print("Thank you!")

# while True:
#     name = input("请输入用户名->:")
#     if name != 'Joe':
#         continue
#     print("Hello, Joe. What is the password? (It is a fish.)")
#     password = input("请输入密码->:")
#     if password == 'abcd1234':
#         break
# print("Access granted.")

# for
# print("My name is ")
# for i in range(5):
#     print("Jimmy Five Times (' + str(i) +')",i+1)

# total = 0
# for num in range(101):
#     total = total + num
# print(total)

# for i in range(12,16):
# #     print(i)

# for i in range(0,101,2):
#     print(i)

# for i in range(5,-1,-1):
#     print(i)

# import random
# for i in range(5):
#     print(random.randint(1,10))

import random,sys,os,math

from random import *

# import sys
# while True:
#     print("Type exit to exit.")
#     response = input("输入exit即可退出->:").strip()
#     if response == "exit":
#         sys.exit("程序退出20180427")
#     print("You typed"+response + ' .')

# spam = input("请输入1或者2->:")
# if spam.isdigit():
#     spam = int(spam)
#     if spam == 1:
#         print("Hello %s"%spam)
#     elif spam == 2:
#         print("Howdy %s"%spam)
#     else:
#         print("Greetings!")
# else:
#     print("您输入的不是数字1或者2")

# for i in range(10):
#     print('loop range(10) %s'%i)
# for i2 in range(0,10):
#     print('loop range(0,10) %s'%i2)
#
# for i3 in range(0,10,1):
#     print('loop range(0,10,1) %s'%i3)

# 编写一小段程序，利用for循环，打印出从1到10数字。
# for i in range(1,11):
#     print('for loop : %s'%i)
# # 利用while循环，编写一个程序，打印出从1到10的数字
# count = 0
# while count <10:
#     count += 1
#     print("while loop：%s"%count)

# def hello():
#     print("Howdy!")
#     print("Howdy!!!")
#     print("Hello there.")
# hello()
# hello()
# hello()

# def hello(name):
#     print("Hello " + name)
# hello("Alice")
# hello("Bob")

# import random
# def getAnswer(answerNumber):
#     if answerNumber == 1:
#         return "It is certain"
#     elif answerNumber == 2:
#         return "It is decidedly so"
#     elif answerNumber == 3:
#         return "Yes"
#     elif answerNumber == 4:
#         return "Reply hazy try again"
#     elif answerNumber == 5:
#         return "Ask again later"
#     elif answerNumber == 6:
#         return "Concentrace and ask again"
#     elif answerNumber == 7:
#         return "My reply is no"
#     elif answerNumber == 8:
#         return "Outlook not so good"
#     elif answerNumber == 9:
#         return "Very doubtful"
# print(getAnswer(random.randint(1,9)))

# print("Hello",end=' ')
# print("World")
#
# print("cats","dogs","mice")
# print("cats","dogs","mice",sep=' ,')

# def spam():
#     eggs = 31337
# spam()
# print(eggs)

# def spam():
#     #eggs = 99
#     bacon()
#     print(eggs)
# def bacon():
#     ham = 101
#     eggs = 0
# spam()

# def spam():
#     print(eggs)
# eggs=42
# spam()
# print(eggs)

# def spam():
#     eggs = 'spam local'
#     print(eggs) # prints 'spam local'
# def bacon():
#     eggs = 'bacon local'
#     print(eggs) # prints 'bacon local'
#     spam()
#     print(eggs) # prints 'bacon local'
# eggs = 'glocal'
# bacon()
# print(eggs) # prints 'global'

# def spam():
#     global eggs
#     eggs = 'spam'
# eggs = 'global'
# spam()
# print(eggs)

# def spam():
#     global eggs
#     eggs = 'spam' # this is the global
# def bacon():
#     eggs = 'bacon' # this is a local
# def ham():
#     print(eggs) # this is the global
#
# eggs = 42 # this is the global
# spam()
# print(eggs)

# def spam():
#     print(eggs) # ERROR!
#     eggs = 'spam local'
# eggs = 'global'
# spam()

# def spam(divideBy):
#     try:
#         return 42 / divideBy
#     except ZeroDivisionError:
#         print("Error: Invalid argument.")
# print(spam(2))
# print(spam(12))
# print(spam(0))
# print(spam(1))

# def spam(divideBy):
#     return 42 / divideBy
# try:
#     print(spam(2))
#     print(spam(12))
#     print(spam(0))
#     print(spam(1))
# except ZeroDivisionError:
#     print("Error: Invalid argument .")

# This is a guess the number game
# import random
# secretNumber = random.randint(1,20)
# print("I'm thinking of a number between 1 and 20.")
#
# # Ask the player to guess 6 times.
# for guessesTaken in range(1,7):
#     print("Take a guess.")
#     guess = int(input("请输入一个数字->:"))
#
#     if guess < secretNumber:
#         print("Your guess is too low.")
#     elif guess > secretNumber:
#         print("Your guess is too high.")
#     else:
#         break # This condition is the correct gues!
# if guess == secretNumber:
#     print("Good job! You guessed my number in "+ str(guessesTaken) +' guesses!')
# else:
#     print("Nope. The number I was thinking of was "+ str(secretNumber))

# cat_names =[]
# while True:
#     name = input("Enter the name of cat %s (or enter nothing to stop.->:)"%str(len(cat_names)+1))
#     if name == "":
#         break
#     cat_names = cat_names + [name] # list concatenation
# print("The cat names are: ")
# for name in cat_names:
#     print(' '+name)

# for i in range(4):
#     print('loop: ',i)

# for i in [0, 1, 2, 3]:
#     print('loop: ',i)

# supplies = ['pens', 'staplers', 'flame-throwers', 'binders']
# for i in range(len(supplies)):
#     print('Index '+str(i) + ' in supplies is: '+supplies[i])
#

# 'howdy' in ['hello', 'hi', 'howdy', 'heyas']
# spam = ['hello', 'hi', 'howdy', 'heyas']
# 'cat' in spam
# 'howdy' not in spam
# 'cat' not in spam
#

# my_pets = ['Zophie', 'Pooka', 'Fat-tail']
# name = input('Enter a pet name->: ')
# if name not in my_pets:
#     print('I do not have a pet named ' + name)
# else:
#     print(name + ' is my pet. ')

# import random
# messages = [
#     'It is certain',
#     'It is decidedly so',
#     'yes definitely',
#     'Reply hazy try again',
#     'Ask again later',
#     'Concentrate and ask again',
#     'My reply is no',
#     'Outlook not so good',
#     'Very double'
# ]
#
# print(messages[random.randint(0,len(messages)-1)])

# def eggs(someParameter):
#     someParameter.append('Hello')
# spam = [1, 2, 3]
# eggs(spam)
# print(spam)


# for i in {1..10}
# do
#     svn up /home/www/html/yhz/ >>/tmp/3.sh ; sleep 3
# done

# 4.10 实践项目
# 	作为实践，编程完成下列任务。
# 4.10.1 逗号代码
# 	假定有下面这样的列表：
# 	spam = ['apples', 'bananans', 'tofu', 'cats']
# 编写一个函数，它以一个列表值作为参数，返回一个字符串。该字符串包含所有表项，表项之间以逗号和空格分隔，
# 并在最后一个表项之前插入and。例如，将前面的spam列表传递给函数，将返回'apples, bananas, tofu, and cats'。
spam = ['apples', 'bananans', 'tofu', 'cats']
def print_str(a):
        print(str(i))
print_str(spam)







