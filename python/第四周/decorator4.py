#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
import time
user,passwd='alex','abc123'
def auth(func):
	def wrapper(*args,**kwagrs):
		username = input("UserName: ").strip()
		password = input("PassWord: ").strip()
		
		if user == username and passwd == password:
			print("\033[32;1mUserName has passed authentication\033[0m")
			func(*args,**kwagrs)
		else:
			exit("\033[31;1mInvalid username or password\033[0m")
	return wrapper
def index():
	print("welcome to index page")
@auth
def home():
	print("welcome to home page")
@auth
def bbs():
	print("welcome to bbs page")
index()
home()
bbs()