#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
menu = {
	"北京":{
		"朝阳":{},
		"海淀":{
			"五道口":{
				"soho":{},
				"网易":{},
				"google":{}
			},
			"中关村":{
				"爱奇艺":{},
				"汽车之家":{},
				"youku":{}
			},
			"上地":{
				"百度":{}
			}
		},
		"昌平":{
			"沙河":{
				"老男孩":{
					"路飞":{},
					"娜美":{}
				},
				"北航":{}
			},
			"天通苑":{},
			"回龙观":{}
		},
		"东城":{}
	},
	"上海":{
		"浦东":{},
		"静安":{},
		"闵行":{
			"人民广场":{
				"炸鸡店":{}
			}
		}
	},
	"山东":{
		"青岛":{},
		"济南":{},
		"潍坊":{}
	}
}

current_layer = menu
layers = []
while True:
	for k in current_layer: #menu[北京]
		print(k)
	choice = input(">:").strip()
	if not choice:
		continue
	if choice in current_layer: #menu[北京]
		layers.append(current_layer) # 进入下一层前，保存当前层
		print(layers)
		current_layer = current_layer[choice] # menu[北京][昌平]
	elif choice == "b":
		if len(layers) != 0:
			current_layer = layers.pop()
		else:
			break