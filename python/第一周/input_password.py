# -*- coding:utf-8 -*-
# Author: davie
# 不用安装，直接导入的，叫做标准库
import getpass

_username = 'davie'
_password = 'abc123'

username = input("username: ")
password = input("password: ")
#password = getpass.getpass("password: ") # 在pycharm中不好使
#print(username,password)
if _username == username and _password == password:
    print("Welcome {name} to login in.".format(name=username))
else:
    print("Invalid username or password!")
