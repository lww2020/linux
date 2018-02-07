#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
#import sys
#print(sys.argv[2])
import os
#cmd_df= os.system("df -Th") # 执行命令，不保存结果
cmd_df=os.popen("df -Th").read()
print(cmd_df)
os.mkdir("new_dir2")

