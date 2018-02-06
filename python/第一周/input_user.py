# -*- coding:utf-8 -*-
# Author: davie
"""
username = input("username: ")
password = input("password: ")
#print(username)
#print(password)
info = '''
---------- info of ''' + username + '''  ----------
姓名: '''+ username + '''
密码: ''' + password +'''
----------  info end ----------
'''
print(info)
"""

username = input("Name: ")
gneder   = input("Sex:  ")
age      = int(input("Age: "))  # age = str(int(input("Age: "))) # integer
job      = input("Job:  ")
salary   = int(input("Salary: ")) # integer

info1 = '''
---------- info of %s ----------
 姓名：%s
 性别：%s
 年龄：%s
 工作：%s
 薪资：%s
----------     end    ----------
''' % (username,username,gneder,age,job,salary)

info2 = '''
---------- info of {_username} ----------
 姓名：{_username}
 性别：{_gneder}
 年龄：{_age}
 工作：{_job}
 薪资：{_salary}
----------     end    ----------
'''.format (
    _username=username,
    _gneder=gneder,
    _age=age,
    _job=job,
    _salary=salary)

#print(info2)

info3 = '''                               
---------- info of {0} ---------- 
 姓名：{1}                           
 性别：{2}                             
 年龄：{3}                                
 工作：{4}                                
 薪资：{5}                             
----------     end    ----------          
'''.format (username,username,gneder,age,job,salary)

print(info3)