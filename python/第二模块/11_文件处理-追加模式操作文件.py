#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
追加
把内容追加到文件末尾
f = open(file='girls_info.txt',mode='a',encoding='utf-8')
f.write('\n杜姗姗 北京 167 49 13324523342')
f.close()

注意：
1、文件操作时，以"a"或者"ab"模式打开，则只能追加，即，在原有内容
的尾部追加内容
2、写入到硬盘上时，必须是某种编码的01010101，打开时需要注意：
	ab. 写入时需要直接传入以某种编码的01010101，即字节类型
	a和encoding，写入时需要传入unicode字符串，内部会根据encoding
	指定的编码将unicode字符串转换为该编码的01010101
"""
f = open(file='girls_info.txt',mode='a',encoding='utf-8')
f.write('\n杜姗姗 北京 167 49 13324523342')
f.close()
