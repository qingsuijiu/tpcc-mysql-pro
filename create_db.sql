-- create database
drop database if exists `tpcc100`;
create database tpcc100;
use tpcc100;
-- create table;
source /home/fanyang/fanyang_home/tpcc-mysql-pro/create_table.sql;
-- add index
source /home/fanyang/fanyang_home/tpcc-mysql-pro/add_fkey_idx.sql;
-- 增加prepared_stmt，在连接线程数较多的情况，如果该值较小，会出现问题
set global max_prepared_stmt_count=300000;