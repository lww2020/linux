#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
"""
文件处理-文件修改功能
f = open(file='girls_info.txt',mode='r+',encoding='utf-8')
f.seek(6)
f.write("[路飞学城]")
f.close()
"""
import os
f_name = "girls_info.txt"
f_new_name = "%s.new" %(f_name)
old_str = "乔亦菲"
new_str = "杜十娘"
f = open(file=f_name,mode="r",encoding="utf-8")
f_new = open(file=f_new_name,mode="w",encoding="utf-8")
for line in f:
	if old_str in line:
		line = line.replace(old_str,new_str)
	f_new.write(line)
f.close()
f_new.close()
os.rename(f_new_name,f_name)

##############################
#!/usr/bin/env python3
# -*- coding: utf-8-*-
import os
old_str = "乔亦菲"
new_str = "[乔亦菲 yifei Qiao]"
f_old_name='/root/test/girls_info.txt'
f_new_name='%s.bak'%(f_old_name)
f_old = open(file=f_old_name,mode="r",encoding="utf-8")
f_new = open(file=f_new_name,mode="w",encoding="utf-8")

for line in f_old:
	if old_str in line:
		new_line = line.replace(old_str,new_str)
	else:
		new_line = line
	f_new.write(new_line)
f_old.close()
f_new.close()
os.rename(f_new_name,f_old_name)

