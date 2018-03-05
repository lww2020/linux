MySQL设置了同步后，如何让从库不执行delete命令
https://zhidao.baidu.com/question/166375076.html

设置一个没有delete权限的帐号

开一个空权限帐号sys，密码为password
GRANT usage on *.* to sys@'%' identified by "password";

赋予sys所有库的所有权限
GRANT all on *.* to  sys;

回收sys的所有库的drop和delete权限
REVOKE drop on *.* FROM  sys;
REVOKE delete on  *.* from   sys;

当然，库名也可以指定
*.* 换成xx_table.*