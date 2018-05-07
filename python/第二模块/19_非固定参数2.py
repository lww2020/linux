#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
def func(name,*args,**kwargs):
	print(name,args,kwargs)

d = {"degree":"primary school"}
func('Peiqi',**d)

func('Alex',22,'tela','500W',addr="山东",num='1233445')
