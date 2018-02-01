#!/bin/bash
:<<block
例题二：
【题目要求】
有日志1.log,部分内容如下：
172.16.12.113 - - [19/Oct/2017:17:34:04 +0800] "GET /?nav=ssc&curmid=2489 HTTP/1.1" 200 17508 "-" "http://yhz.test1.com/?controller=default&action=main" "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:56.0) Gecko/20100101 Firefox/56.0" "-" "-" "__lc.visitor_id.5900921=S1493171438.0e10ab667e; the_cookie=the_value; CGISESSID=0d5ee52afb4aed202f6e8b5f6cc230b2; failure=0; buqsno=buqsno59e86e8060613; last_lottery_url=http%3A%2F%2Fyhz.test1.com%2F%3Fnav%3D11y%26curmid%3D2581"
172.16.12.113 - - [19/Oct/2017:17:34:04 +0800] "GET /js/web/common.js?vj=11508405644 HTTP/1.1" 200 20148 "-" "http://yhz.test1.com/?nav=ssc&curmid=2489" "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:56.0) Gecko/20100101 Firefox/56.0" "-" "-" "__lc.visitor_id.5900921=S1493171438.0e10ab667e; the_cookie=the_value; CGISESSID=0d5ee52afb4aed202f6e8b5f6cc230b2; failure=0; buqsno=buqsno59e8718c68c38; last_lottery_url=http%3A%2F%2Fyhz.test1.com%2F%3Fnav%3D11y%26curmid%3D2581"
172.16.12.113 - - [19/Oct/2017:17:34:04 +0800] "GET /js/web/dist/scripts/yhz_publish.min.js?vj=11508405644 HTTP/1.1" 200 94980 "-" "http://yhz.test1.com/?nav=ssc&curmid=2489" "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:56.0) Gecko/20100101 Firefox/56.0" "-" "-" "__lc.visitor_id.5900921=S1493171438.0e10ab667e; the_cookie=the_value; CGISESSID=0d5ee52afb4aed202f6e8b5f6cc230b2; failure=0; buqsno=buqsno59e8718c68c38; last_lottery_url=http%3A%2F%2Fyhz.test1.com%2F%3Fnav%3D11y%26curmid%3D2581"
172.16.12.113 - - [19/Oct/2017:17:34:04 +0800] "POST /?controller=default&action=menu HTTP/1.1" 200 41 "flag=getmoney" "http://yhz.test1.com/?nav=ssc&curmid=2489" "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:56.0) Gecko/20100101 Firefox/56.0" "-" "application/x-www-form-urlencoded; charset=UTF-8" "__lc.visitor_id.5900921=S1493171438.0e10ab667e; the_cookie=the_value; CGISESSID=0d5ee52afb4aed202f6e8b5f6cc230b2; failure=0; buqsno=buqsno59e8718c68c38; last_lottery_url=http%3A%2F%2Fyhz.test1.com%2F%3Fnav%3Dssc%26curmid%3D2489"
统计出每个IP的访问量有多少

【习题分析】
这种分析日志的需求，在平时工作中很常见，而且找运维工作时的笔试题里面出现很频繁。根据
日志内容，可以看到IP地址就是第一列内容，所以只需要把1.log的第一列过滤出来，然后进一步
统计每个IP的访问数量即可。
过滤第一列，使用awk就可以很容易得到，而统计每个IP的访问量则需要排序后在统计数量，排序
使用sort命令，统计每个IP访问量使用uniq。
block

awk -F" " '{print $1}' 1.log | sort -n |uniq -c |sort -nr | head -20
#