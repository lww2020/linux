#!/bin/bash
:<<block
例题四：
【题目要求】
设计一个脚本，监控远程的一台机器(假设IP为180.163.26.39)的存活状态，
当发现宕机时，发送一封邮件给你自己。
提示：
1、你可以使用ping命令 ping -c10 172.16.12.223
2.发邮件脚本可以参考 https://coding.net/u/aminglinux/p/aminglinux-book/git/blob/master/D22Z/mail.py
3、脚本可以搞成死循环，每隔30秒检测一次
【习题分析】
题目中其实已经给出简单的思路，对于这种监控类的脚本，我认为套路就一个：
首先设定一个标准阈值，然后通过一些手段获取到目标的属性值。再拿这个属性值
和标准值进行比较，如果不正常就要做出相应的动作，或发送邮件或者执行某个命令。
本题是要监控一个ip的存活状态，而题目中给出的建议是ping命令，所以不妨先运行
这个命令，看看结果是什么？如下
[root@web ~]# ping -c10 172.16.12.223
PING 172.16.12.223 (172.16.12.223) 56(84) bytes of data.
64 bytes from 172.16.12.223: icmp_seq=1 ttl=64 time=3.49 ms
64 bytes from 172.16.12.223: icmp_seq=2 ttl=64 time=0.382 ms
64 bytes from 172.16.12.223: icmp_seq=3 ttl=64 time=0.500 ms
64 bytes from 172.16.12.223: icmp_seq=4 ttl=64 time=0.419 ms
64 bytes from 172.16.12.223: icmp_seq=5 ttl=64 time=0.540 ms
64 bytes from 172.16.12.223: icmp_seq=6 ttl=64 time=0.393 ms
64 bytes from 172.16.12.223: icmp_seq=7 ttl=64 time=0.471 ms
64 bytes from 172.16.12.223: icmp_seq=8 ttl=64 time=1.10 ms
64 bytes from 172.16.12.223: icmp_seq=9 ttl=64 time=0.513 ms
64 bytes from 172.16.12.223: icmp_seq=10 ttl=64 time=1.62 ms

--- 172.16.12.223 ping statistics ---
10 packets transmitted, 10 received, 0% packet loss, time 9008ms
rtt min/avg/max/mdev = 0.382/0.943/3.491/0.929 ms
[root@web ~]# 
看到上面的结果后，你应该把重点放到最后两行，其中"0% packet loss"是一个
总结性的输出，字面意思是说丢包率为0%。所以，我们就可以拿这个丢包率来说事。
如果不存在了，那这个丢包率就是100%，但实际网络环境中只要丢包率超过20%，就会
有很大问题。由此，可以把标准阈值设置为20。
剩下的事情，就是如何把丢包率的那个数字给获取到。至于后面那个发邮件的脚本。
不是本题所关心的内容，大家可以拿来就用。
block

ip=172.16.12.223
ma=abc@139.com
while 1
do
    n=`ping -c3 172.16.12.223 |grep "received"|awk -F 'received,|%' '{print $2}'|awk -F" " '{print $1}'`
    if [ -z "$n" ]; then
    	echo "There is something wrong in the script."
    	exit
    fi
    if [ $n -ge 20 ]; then
        /usr/bin/python /usr/local/sbin/mail.py $ma "$ip down" "$ip is down"
        # 假设mail.python已经编写设置好了
    fi
    sleep 30
done

:<<block
【答案解析】
1、本题中如何截取到那个丢包率的数字是关键所在。
2、在ping命令后加一个2>/dev/null目的是为了把错误信息输出到/dev/null,在linux世界里，这个文件就是一个黑洞设备，
   无论写多少东西进去，都是无底洞。总之这样做，在脚本运行时不会输出乱七八糟的错误信息。
3、如果你理解不了这条命令ping -c10 $ip 2>/dev/null | grep 'receive'| awk -F 'received, |%' '{print $2}',
   可以从左到右依次执行每一个管道符号左边的命令，这里有一个小技巧，awk -F 后面指定的分隔符是一个
   复杂的用法，如果你看不懂这个，那咱写个简单的，如下：
   awk -F ':|#|.' 它的意思是，分割符可以是":"，也可以是"#"，也可以是"."，多个分隔符用竖线来划分。
   回到本例，分隔符是"received, "(注意，后面有个空格)，也可以是"%"，所以字符串中无论哪个分隔符出现，
   都是同等效果的，而我们要的数字就在第二段。
4、在本例中，把丢包率的数字赋值给变量n，但变量n是否被成功赋值，是需要做一个测试的，如果不能成功赋值，
   那后续的一系列操作都会有问题。[ -z "$n" ]可以判断变量n是否为空。希望大家后续写shell脚本时也要考虑
   到某个关键变量是否被成功赋值的情况。
5、本例中的mail.py内容以及用法，需要大家自行扩展学习。	
block