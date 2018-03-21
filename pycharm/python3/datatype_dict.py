#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
Dictionary (字典)
字典(dictionary)是Python中另一个非常有用的内置数据类型。
列表是有序的对象结合，字典是无序的对象集合。两者之间的区别在与：
字典当中的元素是通过键来存取的，而不是通过偏移量存取。
字典是一种映射类型，字典用{}标识，它是一个无序的键(key):值(value)对集合。
键(key)必须使用不可变类型。
在同一个字典中，键(key)必须是唯一的。
"""
# 实例
dict = {}
dict['one'] = 1     #"1 - 菜鸟教程"
dict[2]     = 2     #"2 - 菜鸟工具"

tinydict    = {"name":"runoob", "code":1, "site":"www.runoob.com"}

print("输出键为\"one\"的值：",dict['one'])      # 输出键为"one"的值
print("输出键为2的值    ：",dict[2])          # 输出键为2的值
print("输出完整的字典    ：",tinydict)         # 输出完整的字典
print("输出所有键      ：",tinydict.keys())  # 输出所有键

# 构造函数dict()可以直接从键值对序列中构建字典如下:
dict([('Runoob',1),('Google',2),('Taobao',3)])
{x:x**2 for x in (2,4,6)}
dict(Runoob=1,Google=2,Taobao=3)

"""
注意：
1、字典是一种映射类型，它的元素是键值对
2、字典的关键字必须为不可变类型，且不能重复。
3、创建空字典用{].

"""
def example(d):
    # d 是一个字典对象
    for c in d:
        print(c)
    # 如果调用函数试试的话，会发现函数会将d的所有键打印出来;
    # 也就是遍历的是d的键,而不是值。
    
# 想要输出key:value的组合
for c in dict:
    print(c,":",dict[c])

"""
创建字典，d必须是一个序列(key,value)元组
其实d不一定必须为一个序列元组，如下：
"""
dict_1 = dict([('a',1),('b',2),('c',3)])    # 元素为元组的列表
dict_2 = dict({('a',1),('b',2),('c',3)})    # 元素为元组的组合
dict_3 = dict([['a',1],['b',2],['c',3]])    # 元素为列表的列表
dict_4 = dict((('a',1),('b',2),('c',2)))    # 元素为元组的元组

"""
集合与字典
无序：集合是无序的，所以不支持索引;字典同样也是无序的，但由于其元素是由键
(key)和值(value)两个属性组成的键值对，可以通过(key)来进行索引
元素唯一性：集合元素是无重复元素的序列，会自动去除重复元素，字典因为其key
唯一性，所以也不会出现相同元素。
"""
"""
复数是由一个实数和一个虚数组合构成，表示为: x+yj
一个负数时一对有序浮点数(x,y),其中x是实数部分,y是虚数部分。
Python语言中有关负数的概念:
1、虚数不能单独存在，它们总是和一个值为0.0的实数部分一起构成一个复数
2、复数由实数部分和虚数部分构成
3、表示虚数的语法：real+imagej
4、实数部分和虚数部分都是浮点数
5、虚数部分必须有后缀j或者J

复数的内建属性：
复数对象拥有数据属性，分别为该复数的实部和虚部。
复数还拥有conjugate方法，调用它可以返回该复数的共轭复数对象。
复数属性：real(复数的实部)、image(复数的虚部)、conjugate()(返回复数的共轭复数)
"""
class Complex(object):
    '''创建一个静态属性用来记录类版本号'''
    version=1.0
    '''创建一个复数类，用于操作和初始化复数'''
    def __init__(self,rel=15,img=15):
        self.realPart=rel
        self.imagPart=img

    # 创建复数
    def createComplex(self):
        return self.realPart+self.imagPart
    # 获取输入数字部分的虚部
    def getImg(self):
        # 把虚部转换成字符串
        img-str(self.imagPart)
        # 对字符串进行切片操作获取数字部分
        img-img[:-1]
        return float(img)

    def test():
        print("run test...............")
        com-Complex()
        Cplex = com.creatComplex()
        if Cplex.imag==com.getImg():
            print("com.getImg")
        else:
            pass
        if Cplex.real==com.realPart:
            print("com.realPart")
        else:
            pass

        # 原复数
        print("the relogion comples is :",Cplex)

        # 求取共轭复数
        print("the conjugate complex is :"，Cplex.conjugate())
if __name__ =="__main__":
    test()
