drop database if exists `tpcc100`;
create database tpcc100;
use tpcc100;
source /home/fanyang/fanyang_home/tpcc-mysql-pro/create_table.sql;
source /home/fanyang/fanyang_home/tpcc-mysql-pro/add_fkey_idx.sql;
set global max_prepared_stmt_count=300000;