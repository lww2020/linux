#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
names = ['alex','jack','rain','mack','racheal','shanshan',1,3,2,4,5,6,2,7,8,9,7,6,2]
first_index = names.index(2)
new_list = names[first_index+1:]
second_index=new_list.index(2)
second_value=names[first_index+second_index+1]
print(names[names.index(2)+names[names.index(2)+1:].index(2)+1])




