-- 移动表或对象到别的表空间
a、检查信息与状态
b、移动对象(表与索引)到另外一个表空间
c、检查信息
d、通过重建索引的方法移动索引
e、再次检查确认

-- 1、检查信息与状态
-- 查看表空间信息
select * from dba_tablespaces;
select * from v$tablespace;

-- 查看数据文件
select * from dba_data_files where tablespace_name='IT2';
select * from v$datafile;
select name,bytes/1024/1024 from v$datafile;

-- 2、移动对象到另外一个表空间
-- 目的是把表空间IT2的itpux用户下的表table01迁移到表空间ITPUX08


-- 迁移前查询
-- table01、idx_table01_id
-- tbs: IT2 
select * from dba_segments where owner='ITPUX' and segment_name IN ('table01','IDX_TABLE01_ID');


-- type：index and table
select * from dba_objects where owner='ITPUX' and object_name IN ('table01','IDX_TABLE01_ID');
select * from dba_indexes where owner='ITPUX' and index_name='IDX_TABLE01_ID';

create table itpux.table01(id number(12),c_date date);
insert into itpux.table01 values(1,sysdate);
insert into itpux.table01 values(2,sysdate);
insert into itpux.table01 values(3,sysdate);
insert into itpux.table01 values(4,sysdate);
insert into itpux.table01 values(5,sysdate);

create index idx_table01_id on itpux.table01('id');
commit;

-- 3、检查信息
select * from dba_segments where owner='ITPUX' and segment_name IN ('table01','IDX_TABLE01_ID');
select * from dba_objects where owner='ITPUX' and object_name IN ('table01','IDX_TABLE01_ID');
select * from dba_indexes where owner='ITPUX' and index_name='IDX_TABLE01_ID';

-- 4、通过重建索引的方法移动索引
alter table itpux.table01 move tablespace itpux08;
alter index itpux.idx_table01_id rebuild tablespace itpux08;

-- 5、迁移后查询
select * from dba_segments where owner='ITPUX' and segment_name IN ('table01','IDX_TABLE01_ID');
select * from dba_objects where owner='ITPUX' and object_name IN ('table01','IDX_TABLE01_ID');
select * from dba_indexes where owner='ITPUX' and index_name='IDX_TABLE01_ID';

-- 6、如果有大字段 lob
alter table itpux.table01 move lob(date) store as (tablespace itpux08);

