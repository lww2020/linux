-- 1.查看数据库的大小
use 数据库名
SELECT sum(DATA_LENGTH)+sum(INDEX_LENGTH)
FROM information_schema.TABLES where TABLE_SCHEMA='数据库名';
-- 得到的结果是以字节为单位，除1024为K，除1048576为M。


-- 2.查看表的最后mysql修改时间

select TABLE_NAME,UPDATE_TIME from INFORMATION_SCHEMA.tables where TABLE_SCHEMA='数据库名';
-- 可以通过查看数据库中表的mysql修改时间，来确定mysql数据库是否已经长期不再使用。


-- 3.查看数据库中各个表占用的空间大小
SELECT 
  TABLE_NAME,
  (DATA_LENGTH + INDEX_LENGTH)/1024/1024 AS 'MB',
  TABLE_ROWS 
FROM
  information_schema.TABLES 
WHERE TABLE_SCHEMA IN ('db1','db2')
--  AND TABLE_NAME = '表名' 
ORDER BY TABLE_ROWS desc limit 20;

