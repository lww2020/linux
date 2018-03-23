#!/bin/bash
# 环境：
# 1、Linux：CentOS release 6.9 (Final) (最小化安装)
# 2、Nginx：1.10.3
# 3、MySQL：mysql-5.7.21
# 4、PHP：  php-7.2.0

########################---- Centos最小化安装推荐常用依赖包---- ######################
yum  clean all
yum -y update
yum -y install gcc-c++ gd libxml2-devel libjpeg-devel libpng-devel net-snmp-devel wget telnet vim zip unzip 
yum -y install curl-devel libxslt-devel pcre-devel libjpeg libpng libcurl4-openssl-dev 
yum -y install libcurl-devel libcurl freetype-config freetype freetype-devel unixODBC libxslt 
yum -y install gcc automake autoconf libtool openssl-devel  gcc*
yum -y install perl-devel perl-ExtUtils-Embed wget screen libmemcached
yum -y install cmake ncurses-devel.x86_64  openldap-devel.x86_64 lrzsz  openssh-clients gcc-g77  bison 
yum -y install libmcrypt libmcrypt-devel mhash mhash-devel bzip2 bzip2-devel
yum -y install ntpdate rsync svn  patch  iptables iptables-services libiconv
yum -y install libevent libevent-devel  cyrus-sasl cyrus-sasl-devel *libltdl* *libXtst-dev*
yum -y install gd-devel libmemcached-devel memcached git libssl-devel libyaml-devel auto make
yum -y install gcc gcc-c++ make autoconf automake ncurses-devel bison ncurses  cmake libaio libaio-devel  boost
yum -y groupinstall "Server Platform Development" "Development tools"
yum -y groupinstall "Development tools" 

#一 准备工作
#1. 关闭SELINUX
#修改配置文件,重启服务后永久生效。
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
#命令行设置立即生效
setenforce 0

#2、防火墙设置
cp /etc/sysconfig/iptables /root/iptables.bak.$$
cat >/etc/sysconfig/iptables <<EOF 
# Firewall configuration written by system-config-firewall
# Manual customization of this file is not recommended.
*filter
:INPUT DROP [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 11211 -j ACCEPT

-A INPUT -s 203.190.69.142/32 -p udp -m udp --dport 161 -j ACCEPT

-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
EOF
/etc/init.d/iptables  restart

#3. 时间同步
cat >/root/ntp.sh <<EOF
#!/bin/bash
# ntp.sh
#NTP服务器数组列表
ntpServer=(
[0]=1.cn.pool.ntp.org
[1]=0.cn.pool.ntp.org
[2]=2.cn.pool.ntp.org
[3]=3.cn.pool.ntp.org
)

#校验#
serverNum=`echo \${#ntpServer[*]}`
NUM=0
for ((i=0; i<=\$serverNum; i++)); do
    echo -n "正在和NTP服务器:\${ntpServer[\$NUM]}校验中..."
    /usr/sbin/ntpdate \${ntpServer[\$NUM]} >> /dev/null 2>&1
    if [ \$? -eq 0 ]; then
        echo -e "\e[1;32m\t[成功]\e[0m"
        echo -e "\e[1;32m同步成功,退出......\e[0m"
        break
    else
        echo -e "\e[1;31m\t[失败]\e[0m"
        echo -e "\e[1;31m继续同步下一个!!!!!\e[0m"
        let NUM++
    fi
    sleep 2
done
EOF
chmod +x /root/ntp.sh
sh /root/ntp.sh

cat >>/etc/crontab <<EOF
01 * * * *  /bin/bash /root/ntp.sh
EOF

cat >>/etc/rc.local <<EOF
/etc/init.d/iptables  stop 
EOF
