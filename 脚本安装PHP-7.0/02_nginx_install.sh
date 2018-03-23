#!/bin/bash
# 二 安装Nginx
# 1. 下载源码包
# 上Nginx官网,复制最新稳定版的下载地址过来,然后用wget下载（接下来需要下载安装包的都可以用wget）：
cd /usr/local/src
wget http://nginx.org/download/nginx-1.10.3.tar.gz
#2. 进行解压编译,进入解压后的nginx-1.10.3文件夹：
tar xvf nginx-1.10.3.tar.gz
cd /usr/local/src/nginx-1.10.3
./configure \
--prefix=/usr/local/nginx \
--sbin-path=/usr/sbin/nginx \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/home/log/nginx/error.log \
--http-log-path=/home/log/nginx/access.log \
--pid-path=/var/run/nginx.pid \
--lock-path=/var/run/nginx.lock \
--http-client-body-temp-path=/home/tmp/nginx/client \
--http-proxy-temp-path=/home/tmp/nginx/proxy \
--http-fastcgi-temp-path=/home/tmp/nginx/fcgi \
--http-uwsgi-temp-path=/home/tmp/nginx/uwsgi \
--http-scgi-temp-path=/home/tmp/nginx/scgi \
--user=nginx \
--group=nginx \
--with-pcre \
--with-http_v2_module \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_stub_status_module \
--with-http_auth_request_module \
--with-mail \
--with-mail_ssl_module \
--with-file-aio \
--with-ipv6 \
--with-http_v2_module \
--with-threads \
--with-stream \
--with-stream_ssl_module

#  完成后执行编译：
#  make && make install
make -j `grep processor /proc/cpuinfo | wc -l` 
make -j `grep processor /proc/cpuinfo | wc -l`  install
mkdir -p /home/tmp/nginx/client
mkdir -p /home/log/nginx

chmod 777 /home/tmp/
chmod 777 /home/log/

#4. 启动服务
useradd -s /sbin/nologin -M nginx
#id nginx

# 出现 Welcome nginx 这玩意说明成功了!
# 注：如果报错 [emerg]: getpwnam("nginx") failed ;
# 解决方法：
# useradd -s /sbin/nologin -M nginx
# id nginx

# 启动方式
/usr/sbin/nginx
# 关闭方式
#  /usr/sbin/nginx -s stop

cat >> /etc/rc.local <<EOF
# nginx 启动和关闭方式
# 启动方式
# /usr/sbin/nginx
# 关闭方式
# /usr/sbin/nginx -s stop
EOF

cat >>/root/.bashrc <<EOF
alias nginx.start='/usr/sbin/nginx'
alias nginx.stop='/usr/sbin/nginx -s stop'
alias nginx.reload='/usr/sbin/nginx -s reload'
alias nginx.config.test='/usr/sbin/nginx -t'
EOF

source /root/.bash_profile



