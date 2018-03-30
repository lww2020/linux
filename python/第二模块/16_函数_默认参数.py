#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
参数可以让你的函数更灵活，不只能做死的动作，还可以根据调用时传参的
不同来决定函数内部的执行流程
形参变量:
	只有在被调用时才分配内存单元，在调用结束时，即刻释放掉所分配的内存单元。
因此，形参只在函数内部有效。函数调用结束返回主调用函数后则不能再使用该形参
变量。

实参：
	可以是常量，变量，表达式，函数等。无论实参是何种类型的量，进行函数调用时，
它们都必须有确定的值，以便把这些值传送给形参。因此应预先用赋值、输入等办法使
参数获得确定值

默认参数
def stu_register(name,age,country,course):
	print("---注册学生信息---")
	print("姓名：",name)
	print("年龄：",age)
	print("国籍：",country)
	print("课程：",course)
	
stu_register("王山炮",22,"CN","python_devops")
stu_register("张晓春",21,"CN","Linux")
stu_register("刘老根",25,"CN","Linux")

发现country这个参数基本都是"CN"
就像我们在网站上注册用户，像国籍这种信息，你不填写，默认就会是中国，
这就是通过默认参数实现的，把country变成默认参数非常简单。

这样，这个参数在调用时不指定，那默认就是CN，指定了的话，就用你指定的值。
另外，你可能注意到了，在把country变成默认参数后，我同时把它的位置移动到了
最后面，为什么了？

def stu_register(name,age,course,country="CN")


def stu_register(name,age,country,course):
	print("registeration info...")
	print(name,age,country,course)
stu_register('Alex',22,'CN','Python')
stu_register('Jack',25,'JP','Ruby')
stu_register('Rain',26,'AM','JAVA')

