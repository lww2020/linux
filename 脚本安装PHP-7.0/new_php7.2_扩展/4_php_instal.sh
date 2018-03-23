# 四 安装php-fpm
# 1. 安装依赖包:
# yum -y install libmcrypt libmcrypt-devel mhash mhash-devel libxml2 libxml2-devel bzip2 bzip2-devel




#  2. 到官网下载源码包后,开始编译安装：
cd /usr/local/src/
wget http://cn2.php.net/distributions/php-7.2.0.tar.bz2
wget https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz
tar -zxf libiconv-1.15.tar.gz 
cd libiconv-1.15
./configure 
make -j `grep processor /proc/cpuinfo | wc -l`  &&
make -j `grep processor /proc/cpuinfo | wc -l`  install 
ln -s /usr/local/lib/libiconv.so.2 /usr/lib64/
echo  "/usr/local/lib/" >> /etc/ld.so.conf
ldconfig

cd /usr/local/src/
wget https://nchc.dl.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz
tar -zxf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure
make -j `grep processor /proc/cpuinfo | wc -l`  &&
make -j `grep processor /proc/cpuinfo | wc -l`  install 
cd ../

cd /usr/local/src/
wget https://nchc.dl.sourceforge.net/project/mhash/mhash/0.9.9.9/mhash-0.9.9.9.tar.gz
tar -zxf mhash-0.9.9.9.tar.gz
cd mhash-0.9.9.9
./configure
make -j `grep processor /proc/cpuinfo | wc -l`  &&
make -j `grep processor /proc/cpuinfo | wc -l`  install 
cd ../

cd /usr/local/src/
wget https://nchc.dl.sourceforge.net/project/libpng/zlib/1.2.11/zlib-1.2.11.tar.gz
tar -zxf zlib-1.2.11.tar.gz 
cd zlib-1.2.11
./configure
make -j `grep processor /proc/cpuinfo | wc -l`  &&
make -j `grep processor /proc/cpuinfo | wc -l`  install 
cd ../


cd /usr/local/src/
useradd -d /var/run/memcached/ -s /sbin/nologin -c "Memcached daemon" memcached
wget http://www.memcached.org/files/memcached-1.5.6.tar.gz
tar -zxf memcached-1.5.6.tar.gz 
cd memcached-1.5.6
./configure --prefix=/usr/local/memcached
make -j `grep processor /proc/cpuinfo | wc -l`  &&
make -j `grep processor /proc/cpuinfo | wc -l`  install 
cd ../

/usr/bin/memcached -d -p 11211 -u memcached -m 1024 -c 10240 -P /var/run/memcached/memcached.pid

# php扩展memcached、memcache、redis的安装配置方法

groupadd redis
useradd -r -g redis -s /sbin/nologin -M redis
cd redis-3.2.5/
make  -j `grep processor /proc/cpuinfo | wc -l` PREFIX=/usr/local/redis install 
mkdir -p /usr/local/redis/data
mkdir -p /usr/local/redis/etc
mkdir -p /var/run/redis
mkdir -p /var/log/redis

cp redis.conf /usr/local/redis/etc/

echo "
bind 0.0.0.0
protected-mode yes
port 6379
tcp-backlog 511
timeout 0
tcp-keepalive 300
daemonize yes
supervised no
pidfile /var/run/redis_6379.pid
loglevel notice
logfile \"/var/log/redis/redis.log\"
databases 16
save 900 1
save 300 10
save 60 10000
stop-writes-on-bgsave-error yes
#rdbcompression yes
#rdbchecksum yes
#dbfilename dump.rdb
dir /usr/local/redis/data/
slave-serve-stale-data yes
slave-read-only yes
repl-diskless-sync no
repl-diskless-sync-delay 5
repl-disable-tcp-nodelay no
slave-priority 100
#appendonly no
#appendfilename \"appendonly.aof\"
#appendfsync everysec
no-appendfsync-on-rewrite no
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
aof-load-truncated yes
lua-time-limit 5000
slowlog-log-slower-than 10000
slowlog-max-len 128
latency-monitor-threshold 0
notify-keyspace-events \"\"
hash-max-ziplist-entries 512
hash-max-ziplist-value 64
list-max-ziplist-size -2
list-compress-depth 0
set-max-intset-entries 512
zset-max-ziplist-entries 128
zset-max-ziplist-value 64
hll-sparse-max-bytes 3000
activerehashing yes
client-output-buffer-limit normal 0 0 0
client-output-buffer-limit slave 256mb 64mb 60
client-output-buffer-limit pubsub 32mb 8mb 60
hz 10
#aof-rewrite-incremental-fsync yes
" >/usr/local/redis/etc/redis.conf

chown -R redis:redis /usr/local/redis
chown -R redis:redis /var/run/redis
chown -R redis:redis /var/log/redis

/usr/local/redis/bin/redis-server  /usr/local/redis/etc/redis.conf


cd /usr/local/src/
wget http://download.redis.io/releases/redis-3.2.5.tar.gz
tar -zxf redis-3.2.5.tar.gz


cd /usr/local/src/
wget https://pecl.php.net/get/redis-3.1.6.tgz



cd /usr/local/src/
wget https://github.com/edtechd/phpredis/archive/php7.zip
unzip  -q php7.zip
cd phpredis-php7/
/usr/local/php/bin/phpize
# find / -name php-config
./configure --with-php-config=/usr/local/php/bin/php-config
make -j `grep processor /proc/cpuinfo | wc -l`  &&
make -j `grep processor /proc/cpuinfo | wc -l`  install 
cd ../



cd /usr/local/src/
tar -xf php-7.2.0.tar.bz2 -C /usr/local/src
cd /usr/local/src/php-7.2.0
# 执行下面的配置文件：
./configure --prefix=/usr/local/php \
--with-config-file-scan-dir=/etc/php.d \
--with-config-file-path=/etc \
--with-mysqli=/usr/local/mysql/bin/mysql_config \
--enable-fpm \
--enable-opcache \
--disable-fileinfo \
--with-jpeg-dir \
--with-iconv-dir=/usr/local/lib/ \
--with-freetype-dir \
--with-png-dir \
--with-zlib \
--with-libxml-dir=/usr \
--enable-xml \
--enable-bcmath \
--enable-shmop \
--enable-exif \
--with-curl \
--enable-sysvsem \
--enable-inline-optimization \
--enable-mbregex \
--enable-inline-optimization \
--enable-mbstring \
--with-gd \
--with-openssl \
--with-mhash \
--enable-pcntl \
--enable-sockets \
--with-xmlrpc \
--enable-ftp \
--with-gettext \
--enable-zip \
--enable-soap \
--with-bz2

#  出现上述错误的解决办法： 
#  参考资料： http://www.ithov.net/linux/1127.html
#wget https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz


make clean
make ZEND_EXTRA_LIBS='-liconv' -j `grep processor /proc/cpuinfo | wc -l`  &&
make -j `grep processor /proc/cpuinfo | wc -l`  install


#  3. 添加php和php-fpm配置文件。
rm -rf /etc/php.ini
cp -f /usr/local/src/php-7.2.0/php.ini-production /etc/php.ini  
cd /usr/local/php/etc/
cp -f php-fpm.conf.default php-fpm.conf
sed -i 's@;pid = run/php-fpm.pid@pid = /usr/local/php/var/run/php-fpm.pid@' php-fpm.conf

#  4. 添加php-fpm启动脚本。
cp -f /usr/local/src/php-7.2.0/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
#  5. 添加php-fpm至服务列表并设置开机自启。
# chkconfig --add php-fpm
# chkconfig --list php-fpm
# chkconfig php-fpm on

# 6. 启动服务
cp -f /usr/local/php/etc/php-fpm.d/www.conf.default  /usr/local/php/etc/php-fpm.d/www.conf
service php-fpm start
ps -ef|grep -v 'grep' | grep php


#  注：启动时如出现错误：
#  解决：到指定目录执行cp www.conf.default www.conf


# 7. 添加nginx对fastcgi的支持,
# 首先备份默认的配置文件。
cp -f /etc/nginx/nginx.conf /etc/nginx/nginx.confbak.$$
rm -rf /etc/nginx/nginx.conf
cp -f /etc/nginx/nginx.conf.default /etc/nginx/nginx.conf

cat > /etc/nginx/nginx.conf <<EOF
user  nginx;
worker_processes  8;

error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '\$remote_addr - \$remote_user [] "\$request" '
    #                  '\$status \$body_bytes_sent "\$http_referer" '
    #                  '"\$http_user_agent" "\$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    server {
        listen       8090;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   /usr/local/nginx/html/;
            index index.php index.html index.htm;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php\$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        location ~ \.php\$ {
            root           html/fastpay;
            try_files      \$uri =404;
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME  \$document_root\$fastcgi_script_name;
            include        fastcgi_params;
        }

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }


    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;

    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;

    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;

    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}
    include vhosts/*;
}
EOF

mkdir -p /etc/nginx/vhosts
cd /etc/nginx/vhosts
mkdir -p /usr/local/nginx/www/
chown -R nginx.nginx /usr/local/nginx/*
cat  >/etc/nginx/vhosts/web <<EOF
server{
     charset utf-8;
     listen 80;
        server_name localhost;
       # autoindex on;
       # autoindex_exact_size off;
       # autoindex_localtime on;
        index index.html index.htm index.php;
     location / {
            root /usr/local/nginx/www/;
	#	fastcgi_pass   127.0.0.1:9000;
            	fastcgi_index  index.php;
            	fastcgi_param  SCRIPT_FILENAME  \$document_root\$fastcgi_script_name;
            	include        fastcgi_params;
            	include        fastcgi.conf;

                #allow 58.71.118.58;
                #deny all;
     }
	location ~ \.php\$ {
            root           /usr/local/nginx/www/;
            try_files      \$uri =404;
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME  \$document_root\$fastcgi_script_name;
            include        fastcgi_params;
            include        fastcgi.conf;
        }
}
EOF

mkdir -p /usr/local/nginx/logs
touch /usr/local/nginx/logs/error.log



chown -R nginx.nginx /usr/local/nginx
chown -R nginx.nginx  /etc/nginx/vhosts

# 8. 重启nginx
/usr/sbin/nginx -s reload 
# 9. 测试是否成功
# 在/usr/local/nginx/html/新建index.php的测试页面,内容如下：
rm -rf /usr/local/nginx/html/
mkdir -p /usr/local/nginx/html/
cat >/usr/local/nginx/www/index.php <<EOF
<?php
phpinfo();
?>
EOF
chown -R nginx.nginx /usr/local/nginx/html/
chown -R nginx.nginx /usr/local/nginx/www/


rm -rf /home/www/html.bak
/usr/sbin/nginx -s reload 
# 访问网址： http://172.16.210.151/


# 9. nginx快捷方式
# 启动和停止： 
alias nginx.start='/usr/sbin/nginx'
alias nginx.stop='/usr/sbin/nginx -s stop'
alias nginx.reload='/usr/sbin/nginx -s reload'
alias nginx.configtest='/usr/sbin/nginx -t'

cat >>/root/.bashrc  <<EOF 
alias nginx.start='/usr/sbin/nginx'
alias nginx.stop='/usr/sbin/nginx -s stop'
alias nginx.reload='/usr/sbin/nginx -s reload'
alias nginx.configtest='/usr/sbin/nginx -t'
EOF

source  /root/.bash_profile

#10、php快捷方式
alias php.start='/etc/init.d/php-fpm start'
alias php.stop='/etc/init.d/php-fpm stop'
alias php.restart='/etc/init.d/php-fpm restart'
alias php.reload='/etc/init.d/php-fpm reload'
alias php.status='/etc/init.d/php-fpm status'
alias php.configtest='/etc/init.d/php-fpm  configtest'

cat >>/root/.bashrc  <<EOF
alias php.start='/etc/init.d/php-fpm start'
alias php.stop='/etc/init.d/php-fpm stop'
alias php.restart='/etc/init.d/php-fpm restart'
alias php.reload='/etc/init.d/php-fpm reload'
alias php.status='/etc/init.d/php-fpm status'
alias php.configtest='/etc/init.d/php-fpm  configtest'
EOF


# 访问页面报错 ： File not found.
# vim /etc/nginx/nginx.conf 
# fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
# 写在/etc/rc.local文件中,方便快速查看

cat >>/etc/rc.local  <<EOF
echo 200000 > /proc/sys/net/nf_conntrack_max
ulimit -SHn 65535
EOF
