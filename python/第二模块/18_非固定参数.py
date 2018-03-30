#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
# 报警，1个运维人员
def send(msg,user):
	pass

# 报警，10个运维人员
send_alert("别那么折腾了","alex")

# 不固定的参数
def send_alert(msg,*args): # (['alex','xxx','yyy'])-->('alex','xxx','yyy')
	for u in args:
		print("报警发送给: ",u)


#  如果参数中出现了*，传递的参数就可以不再是固定个数，
#+ 传递过来的所有参数打包成元组
# 方式一：
send_alert("别那么折腾了",'alex','x')
send_alert("别那么折腾了",'alex','x','y')
send_alert("别那么折腾了",'alex','x','y','z')

# 方式二：
send_alert("别那么折腾了",*['alex','xxx','yyy'])

