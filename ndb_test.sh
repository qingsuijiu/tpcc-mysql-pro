#!/bin/bash

mysql_host="10.224.78.80"
mysql_user=root
mysql_password="123456"
mysql_port=3311

load_time=6000

for loop in 1 4 8 16 32 64 128 256 512 1024
do
    echo "drop and create database begin"
    mysql -h${mysql_host} -P${mysql_port} -u${mysql_user} -p${mysql_password} < create_db.sql
    echo "drop and create database end"
    rm -r *.out
    
    echo "load data begin"
    sh load_data_multi_t_2.sh ${mysql_host} ${mysql_user} ${mysql_password} ${mysql_port}
    sleep ${load_time}
    echo "load data end"
    
    echo "the test for threads num: $loop start"
    sh begin_test_2.sh ${mysql_host} ${mysql_user} ${mysql_password} ${mysql_port} ${loop}
    echo "the test for threads num: $loop end"
    sleep 10
done