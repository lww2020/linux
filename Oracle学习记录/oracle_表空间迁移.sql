/* 表空间的日常操作与维护管理-表空间与对象迁移 */
-- 方法一、在线处理
/*
步骤：
1、查询当前表空间的数据文件和状态
2、使表空间offline
3、移动数据文件
4、alter tablespace 表空间重命名数据文件
5、使表空间online
6、查询当前表空间的数据文件和状态
*/
-- 1、查询目前的表空间名称和对应的文件名称
-- select tablespace_name,file_name from dba_data_files;
SELECT tablespace_name,file_name,online_status FROM dba_data_files WHERE tablespace_name='IT2';

/* 执行结果如下 
1	IT2	/oracle/app/oracle/oradata/db01/itp201.dbf
*/

-- 2 、表空间离线
ALTER tablespace it2 offline;
SELECT tablespace_name,file_name,online_status FROM dba_data_files WHERE tablespace_name='IT2';

-- 3、拷贝文件到目标位置,这里用系统命令 oracle用户操作
cp /oracle/app/oracle/oradata/db01/itp201.dbf /oracle/app/oracle/oradata/db01/it201.dbf

-- 4、修改表空间对应的文件名称
ALTER TABLESPACE it2 rename datafile '/oracle/app/oracle/oradata/db01/itp201.dbf' to '/oracle/app/oracle/oradata/db01/it201.dbf';

-- 5、表空间在线
ALTER tablespace it2 online;
SELECT tablespace_name,file_name,online_status FROM dba_data_files WHERE tablespace_name='IT2';

-- 备注：这里可以删除掉原来的文件(或者一开始使用mv)


-- 方法二、离线处理
/*
步骤：
1、关闭数据库，启动到mount状态
2、移动数文件
3、通过alter database重命名文件
4、打开数据库
5、检查状态
*/
-- 1、
shutdown immediate;
startup mount;

-- 2、移动文件,这里用系统命令 oracle用户操作
cp /oracle/app/oracle/oradata/db01/it201.dbf /oracle/app/oracle/oradata/db01/it2_1.dbf

-- 3、通过alter datafile重命名文件

ALTER DATABASE rename file '/oracle/app/oracle/oradata/db01/it201.dbf'to '/oracle/app/oracle/oradata/db01/it2_1.dbf';

-- 4、打开数据库
alter database open;

-- 5、检查状态
SELECT tablespace_name,file_name,online_status FROM dba_data_files WHERE tablespace_name='IT2';









