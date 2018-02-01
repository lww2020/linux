#!/bin/bash
:<<block
例题三：
【题目要求】
写一个脚本计算一下linux系统所有进程占用内存大小的和。
【习题分析】
本题有一个核心点，就是想办法把所有进程使用的内存统计出来，top或者ps命令
都可以获取每一个进程的内存大小。统计完内存后，然后用for循环把所有内存相加，
最后得到一个内存之和就是本题的答案。
block
sum=0
total_memory=`free |grep 'Mem'|awk -F" " '{print $2}'`
for mem in `ps -aux | awk -F" " '{print $6}' | grep -v 'RSS'|grep -v 'MEM'`
do
	sum=$[$sum+$mem]
done
free_mem=`expr $total_memory - $sum`
echo "The total memory is $total_memory"
echo "The current used memory is $sum"
echo "The free memory is $free_mem"