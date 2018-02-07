#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
info = {
    'stu1101':"TengLna Wu",
    'stu1102':"LongZe Luola",
    'stu1103':"XiaoZe Maliya"
}
'''
字典：
'''
print(info["stu1101"])
info["stu1101"] = "wu zixu"
info["stu1104"] = "Caolaoshi"

# 删除
del info["stu1101"]
info.pop("stu1102")
info.popitem() # 随机删除
print(info.get("stu1106"))
print('stu1103' in  info )
print(info)