#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
city_names = {
    "beijing":{
        "bjcq":["朝阳区","海淀区","西城区"]
    },
    "tianjin":{
        "tjcq":["河东区","塘沽区","滨海新区"]
    },
    "shanghai":{
        "shcq":["浦东新区","静安区","闸北区"]
    }
}
print(city_names)
city_names["beijing"]["bjcq"][2]="丰台区"
print(city_names)

print(city_names.keys())
print(city_names.values())
city_names.setdefault("taiwan",{'www.hao123.com':[1,2]})
print(city_names)