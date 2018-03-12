#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
Python3的执行过程
在看实际代码的例子前，我们来聊聊，python3执行代码的过程
1、解释器找到代码文件，把代码字符串按文件头的编码加载到内存，转成unicode
2、把代码字符串按照语法法则进行解释
3、所有的变量字符串会以unicode编码声明

decode(解码)和encode(编码)
UTF-8 --> decode 解码 --> Unicode
Unicode --> encode 编码 --> GBK / UTF-8 ...

python3: 文件默认编码是 utf-8
		 字符串 编码是 unicode
		 
python2： 文件默认编码是ascii
		  字符串 编码 默认是ascii，
		  如果文件头声明了gbk，那字符串的编码就是gbk
	
unicode 单独类型

"""
