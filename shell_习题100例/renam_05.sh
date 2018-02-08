#!/bin/bash
:<<blcok
例题五：
【题目要求】
找到/123目录下所有的后缀名为.txt的文件
1、批量修改.txt为.txt.bak
2、把所有的.bak文件打包压缩为123.tar.gz
3、批量还原文件的名字，即把增加的.bak再删除

【习题分析】
1、查找.txt的文件，使用find命令可以轻松搞定
2、我们之前学find时，也曾多次使用过xargs命令，用它很容易批量修改文件名
3、打包核心命令 tar czvf，关键在于如何表示所有的.bak文件，如何同时把全部.bak文件打包压缩
4、还原文件名视乎有点复杂，需要借助for循环，需要把文件名做一个特殊处理，
   如何获取原文件名是关键
【习题答案】
block

find /123/* -type f -name "*.txt" >/tmp/txt.list
for f in `cat /tmp/txt.list`
do
    mv $f $f.bak
done

d=`date +%y%m%d%H%M%S`

mkdir /tmp/123_$d
for f in `cat /tmp/txt.list`
do
	cp $f.bak /tmp/123_$d
done

cd /tmp
tar czf 123.tar.gz 123_$d/
for f in `cat /tmp/txt.list`
do
	mv $f.bak $f 
done

:<<block
【答案解析】
1、用find查找所有的*.txt，并把这些文件列表写到/tmp/txt.list文件中，方便后续调用
2、把这些*.txt文件做一个遍历，依次修改文件名，如果不这样，其实一条命令也可以
   搞定，命令如下:
# find /123/ -type f -name "*.txt" | xargs -i mv {} {}.bak
3、为了方便打包压缩所有的.bak文件，需要把所有的.bak文件拷贝到另外的一个目录下，
   为了避免该目录已经存在，所以给目录机上一个时间戳作为后缀，这里用到了date命令，
   该命令在shell脚本中频繁用到，需要大家掌握date命令的用法。
block