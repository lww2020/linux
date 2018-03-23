# 2.5、mysql基本初始化安装
mkdir -p /opt/soft/mysql
cd /opt/soft/mysql/
wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.21-linux-glibc2.12-x86_64.tar.gz
tar -zxf mysql-5.7.21-linux-glibc2.12-x86_64.tar.gz
cd /usr/local/
ln -s /opt/soft/mysql/mysql-5.7.21-linux-glibc2.12-x86_64 mysql

# 2.6、创建所需要的目录
mkdir -p /data/mysql/mysql_3306/{data,logs,tmp}
mkdir -p /data/backup/

# 更改权限
egrep "^mysql" /etc/group >& /dev/null
if [ $? -ne 0 ]; then
    groupadd mysql >& /dev/null
    echo "mysql组已经创建完毕"
    egrep "^mysql" /etc/passwd >& /dev/null
    if [ $? -ne 0 ]; then
        useradd -g mysql mysql -d /home/mysql -s /sbin/nologin >& /dev/null
        echo "mysql用户已经创建完毕" >& /dev/null
    else
       echo  "mysql用户已经存在" >& /dev/null
    fi
else 
    echo "mysql组已经存在" >& /dev/null
    egrep "^mysql" /etc/passwd >& /dev/null
    if [ $? -ne 0 ]; then
        useradd -g mysql mysql -d /home/mysql -s /sbin/nologin >& /dev/null
        echo "mysql用户已经创建完毕" >& /dev/null
    else
       echo  "mysql用户已经存在" >& /dev/null
    fi
fi


# 2.7、创建配置文件

# 排除干扰因素

if [ -f /etc/my.cnf ]; then
        mv /etc/my.cnf /etc/my.cnf.bak
fi 

cat >/data/mysql/mysql_3306/my_3306.cnf <<EOF
# my_3306.cnf
[client]
port            = 3306
socket          = /data/mysql/mysql_3306/tmp/mysql_3306.sock

[mysql]
#prompt="\u@\h:\p  \R:\m:\s [\d]>"
#tee=/data/mysql/mysql_3306/data/query.log
#prompt="\u@\h:\p  \R:\m:\s [\d]>"
prompt = "[\u@\h][\d]>\_"  
connect_timeout = 5
no-auto-rehash

[mysqld]
#misc
user = mysql
basedir = /usr/local/mysql
datadir = /data/mysql/mysql_3306/data
port = 3306
socket = /data/mysql/mysql_3306/tmp/mysql_3306.sock

#timeout
interactive_timeout = 300
wait_timeout = 300

#character set
character-set-server = utf8

open_files_limit = 65535
max_connections = 100
max_connect_errors = 100000

skip-name-resolve = 1
disable-partition-engine-check=1
#logs
log-output=file
slow_query_log = 1
slow_query_log_file = /data/mysql/mysql_3306/logs/mysql_3306_slow.log
log-error = /data/mysql/mysql_3306/logs/mysql_3306_error.log
log_error_verbosity = 3
pid-file = mysql_3306.pid
long_query_time = 1
#log-slow-admin-statements = 1
#log-queries-not-using-indexes = 1
log-slow-slave-statements = 1

#tmp
tmpdir=/data/mysql/mysql_3306/tmp
event_scheduler = 1
performance_schema = on
max_allowed_packet = 32M
character_set_server = utf8mb4
#character_set_server = utf8
default-time-zone = system
default-storage-engine = InnoDB
#bind_address = 172.16.151.248
explicit_defaults_for_timestamp = 1


#binlog
binlog_format = row
server-id = 1813306
log-bin = /data/mysql/mysql_3306/logs/mysql-bin
log-bin-index = /data/mysql/mysql_3306/logs/mysql-bin.index
binlog_cache_size = 4M
max_binlog_size = 1G
max_binlog_cache_size = 2G
sync_binlog = 1
expire_logs_days = 90
#replicate-wild-ignore-table=mysql.%
replicate-wild-ignore-table=test.%
replicate-wild-ignore-table=information_schema.%

#relay log
skip_slave_start = 1
max_relay_log_size = 1G
relay_log_purge = 1
relay_log_recovery = 1
log_slave_updates
#slave-skip-errors=1032,1053,1062

explicit_defaults_for_timestamp=1
#buffers & cache
table_open_cache = 2048
table_definition_cache = 2048
table_open_cache = 2048
max_heap_table_size = 96M
sort_buffer_size = 2M
join_buffer_size = 2M
thread_cache_size = 256
query_cache_size = 0
query_cache_type = 0
query_cache_limit = 256K
query_cache_min_res_unit = 512
thread_stack = 192K
tmp_table_size = 96M
key_buffer_size = 8M
read_buffer_size = 2M
read_rnd_buffer_size = 16M
bulk_insert_buffer_size = 32M

#myisam
myisam_sort_buffer_size = 128M
myisam_max_sort_file_size = 10G
myisam_repair_threads = 1

#innodb
innodb_buffer_pool_size = 4G
innodb_buffer_pool_instances = 1
innodb_data_file_path = ibdata1:1G:autoextend
innodb_flush_log_at_trx_commit = 1
innodb_log_buffer_size = 64M
innodb_log_file_size = 500M
innodb_log_files_in_group = 3
innodb_max_dirty_pages_pct = 50
innodb_file_per_table = 1
innodb_rollback_on_timeout
innodb_status_file = 1
innodb_io_capacity = 2000
transaction_isolation = READ-COMMITTED
innodb_flush_method = O_DIRECT
gtid_mode = ON
enforce_gtid_consistency = ON 
master_info_repository = TABLE
relay-log-info-repository = TABLE
binlog_checksum = NONE
log_slave_updates = ON
binlog_row_image=FULL

# Two-Master configure
#server-1 
#auto-increment-offset = 1
#auto-increment-increment = 2 

#server-2                          
#auto-increment-offset = 2
#auto-increment-increment = 2

# semi sync replication settings #
#plugin_dir = /usr/local/mysql/lib/mysql/plugin
#plugin_load = "validate_password.so;rpl_semi_sync_master=semisync_master.so;rpl_semi_sync_slave=semisync_slave.so"
plugin_dir = /usr/local/mysql/lib/plugin #官方版本的路径
plugin_load = "rpl_semi_sync_master=semisync_master.so;rpl_semi_sync_slave=semisync_slave.so" #官方版本的路径


loose_rpl_semi_sync_master_enabled = on     
loose_rpl_semi_sync_master_timeout = 5000      
loose_rpl_semi_sync_master_trace_level = 32   
loose_rpl_semi_sync_master_wait_no_slave = on 
loose_rpl_semi_sync_slave_enabled = on      
loose_rpl_semi_sync_slave_trace_level = 32
loose_rpl_semi_sync_master_enabled = 1
loose_rpl_semi_sync_slave_enabled = 1
loose_rpl_semi_sync_master_timeout = 5000
loose_rpl_semi_sync_master_wait_for_slave_count=1
loose_rpl_semi_sync_master_wait_point=AFTER_SYNC

slave_preserve_commit_order = 1
slave_transaction_retries = 128
log_timestamps = system
show_compatibility_56 = on
slave_parallel_workers = 16
slave_parallel_type = LOGICAL_CLOCK

loose_innodb_numa_interleave = 1
innodb_buffer_pool_dump_pct = 40
innodb_page_cleaners = 16
innodb_undo_log_truncate = 1
innodb_max_undo_log_size = 2G
innodb_purge_rseg_truncate_frequency = 128
#transaction_write_set_extraction = MURMUR32
# READ-UNCOMMITTED, READ-COMMITTED, REPEATABLE-READ, SERIALIZABLE ##
transaction_isolation = READ-COMMITTED
sql_mode = "STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,ONLY_FULL_GROUP_BY"


# group replication
##log-bin = mysql 
##server-id = 613306
##gtid_mode = ON
##enforce_gtid_consistency = ON 
##master_info_repository = TABLE
##relay-log-info-repository = TABLE
##binlog_checksum = NONE
##log_slave_updates = ON 
##binlog_format = row
##transaction_write_set_extraction=XXHASH64
##loose-group_replication_group_name = '3db33b36-0e51-409f-a61d-c99756e90154'
##loose-group_replication_start_on_boot = off
##loose-group_replication_local_address= "10.125.141.62:23306"  # 不能超过5位数 字
##loose-group_replication_group_seeds= "10.125.141.62:23306,10.125.141.62:23307,10.125.141.62:23308"  # 不能超过5位数字
##loose-group_replication_bootstrap_group= off
# loose-group_replication_single_primary_mode=FALSE   ###本次搭建的是mutil_mode
# loose-group_replication_enforce_update_everywhere_checks= TRUE

[mysqld_safe]
#malloc-lib=/usr/local/mysql/lib/jmalloc.so 
nice=-19
open-files-limit=65535
EOF

# 2.8、初始化数据库
chown -R mysql.mysql /data
chown -R mysql.mysql /usr/local/mysql
chown -R mysql.mysql /data/backup/
chmod -R 775 /data/backup/

/usr/local/mysql/bin/mysqld --defaults-file=/data/mysql/mysql_3306/my_3306.cnf --initialize-insecure &

# 查看日志
# tail -f /data/mysql/mysql_3306/logs/mysql_3306_error.log

# 2.9、启动数据库推荐做法
#/usr/local/mysql/bin/mysqld_safe --defaults-file=/data/mysql/mysql_3306/my_3306.cnf & 

cat >>/etc/rc.local <<EOF
/usr/local/mysql/bin/mysqld_safe --defaults-file=/data/mysql/mysql_3306/my_3306.cnf &
EOF

###################################################
###################################################


# mysql设置便捷使用方式
# 输入密码： rootpwd2017
#    /usr/local/mysql/bin/mysql_config_editor set --host=localhost --login-path=3306_localhost_login --user=root --port=3306  --password --socket=/data/mysql/mysql_3306/tmp/mysql_3306.sock
#    
#    alias mysql.3306.start='/usr/local/mysql/bin/mysqld_safe --defaults-file=/data/mysql/mysql_3306/my_3306.cnf &'
#    alias mysql.3306.stop='/usr/local/mysql/bin/mysqladmin --defaults-file=/data/mysql/mysql_3306/my_3306.cnf --login-path=3306_localhost_login shutdown &'
#    alias mysql.3306.login='/usr/local/mysql/bin/mysql --defaults-file=/data/mysql/mysql_3306/my_3306.cnf --login-path=3306_localhost_login'
#    # alias mysql.3306.all_dump='/usr/local/mysql/bin/mysqldump --defaults-file=/data/mysql/mysql_3306/my_3306.cnf --login-path=3306_localhost_login  -R -E --triggers -e --max_allowed_packet=16777216 --net_buffer_length=16384  --default-character-set=utf8mb4 --set-gtid-purged=OFF --master-data=2 --single-transaction --all-databases --quick | gzip >/data/backup/all_database_bak_`date +%Y-%m-%d_%H_%M_%S`.sql.gz'
#    
#    
#    cat  >>/root/.bashrc <<EOF
#    alias mysql.3306.start='/usr/local/mysql/bin/mysqld_safe --defaults-file=/data/mysql/mysql_3306/my_3306.cnf &'
#    alias mysql.3306.stop='/usr/local/mysql/bin/mysqladmin --defaults-file=/data/mysql/mysql_3306/my_3306.cnf --login-path=3306_localhost_login shutdown &'
#    alias mysql.3306.login='/usr/local/mysql/bin/mysql --defaults-file=/data/mysql/mysql_3306/my_3306.cnf --login-path=3306_localhost_login'
#    # alias mysql.3306.all_dump='/usr/local/mysql/bin/mysqldump --defaults-file=/data/mysql/mysql_3306/my_3306.cnf --login-path=3306_localhost_login  -R -E --triggers -e --max_allowed_packet=16777216 --net_buffer_length=16384  --default-character-set=utf8mb4 --set-gtid-purged=OFF --master-data=2 --single-transaction --all-databases --quick | gzip >/data/backup/all_database_bak_`date +%Y-%m-%d_%H_%M_%S`.sql.gz'
#    EOF
#    
#    source  /root/.bash_profile
#    
#    cat  >>/etc/rc.local <<EOF
#    #  alias mysql.3306.start='/usr/local/mysql/bin/mysqld_safe --defaults-file=/data/mysql/mysql_3306/my_3306.cnf &'
#    #  alias mysql.3306.stop='/usr/local/mysql/bin/mysqladmin --defaults-file=/data/mysql/mysql_3306/my_3306.cnf --login-path=3306_localhost_login shutdown &'
#    #  alias mysql.3306.login='/usr/local/mysql/bin/mysql --defaults-file=/data/mysql/mysql_3306/my_3306.cnf --login-path=3306_localhost_login'
#    ##  alias mysql.3306.all_dump='/usr/local/mysql/bin/mysqldump --defaults-file=/data/mysql/mysql_3306/my_3306.cnf --login-path=3306_localhost_login  -R -E --triggers -e --max_allowed_packet=16777216 --net_buffer_length=16384  --default-character-set=utf8mb4 --set-gtid-purged=OFF --master-data=2 --single-transaction --all-databases --quick | gzip >/data/backup/all_database_bak_`date +%Y-%m-%d_%H_%M_%S`.sql.gz'
#    EOF
#    
#    # 创建链接文件
#    # mysql5.7.20
#    # ln -s /usr/local/mysql/lib/libmysqlclient.so /usr/lib/
#    # ln -s /usr/local/mysql/lib/libmysqlclient.so.20 /usr/lib/libmysqlclient.so.20
#    
#    # mysql5.6.38
#    # ln -s /usr/local/mysql/lib/libmysqlclient.so /usr/lib/
#    # ln -s /usr/local/mysql/lib/libmysqlclient.so.18 /usr/lib/libmysqlclient.so.18
#    
#    # percona-mysql5.6.38 
#    # ln -s /usr/local/mysql/lib/libperconaserverclient.so /usr/lib/
#    # ln -s /usr/local/mysql/lib/libperconaserverclient.so.18 /usr/lib/
#    # 
#    # ln -s /usr/local/mysql/lib/libperconaserverclient.so /usr/lib64/
#    # ln -s /usr/local/mysql/lib/libperconaserverclient.so.18 /usr/lib64/
#    
#    # mysql5.7.21
#    ln -s /usr/local/mysql/lib/libmysqlclient.so /usr/lib/
#    ln -s /usr/local/mysql/lib/libmysqlclient.so.20 /usr/lib/libmysqlclient.so.20
#    ln -s /usr/local/mysql/lib/libmysqlclient.so /usr/lib64/
#    ln -s /usr/local/mysql/lib/libmysqlclient.so.20 /usr/lib64/libmysqlclient.so.20

