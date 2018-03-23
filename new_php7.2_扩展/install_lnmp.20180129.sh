#!/bin/bash
mkdir -p /opt/logs
chmod 777 /opt/logs
sh /opt/1_system_init.sh.sh    >>/opt/logs/1_system_init.sh.log    2>&1
sh /opt/nginx_install_02.sh  >>/opt/logs/nginx_install_02.log  2>&1
sh /opt/mysql_install_03.sh  >>/opt/logs/mysql_install_03.log  2>&1
sh /opt/php_instal_04.sh     >>/opt/logs/php_instal_04.log     2>&1
echo "请参考mysql_config_05.sh"