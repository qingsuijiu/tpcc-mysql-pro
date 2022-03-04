#!/bin/bash

mysql_host="10.224.158.165"
mysql_user=root
mysql_password="123456"
mysql_port=3311

load_time=6000

    /usr/bin/expect <<-EOF
    set timeout 20
    spawn ssh fanyang@10.224.158.165
    expect "*password*"
    send "123456\r"
    expect "#*"
    send "cd /home/fanyang/fanyang_home/page_cache_dbengine_deploy \r"
    send "sh close_mysqld.sh \r"
    send "export LD_LIBRARY_PATH=./lib \r"
    send "nohup ./bin/mysqld --defaults-file=myfy.cnf & \r"
    send "exit\r"
    expect eof
EOF
    echo "mysqld restart success"
    sleep 200

    cd ..
    echo "drop and create database begin"
    mysql -h${mysql_host} -P${mysql_port} -u${mysql_user} -p${mysql_password} < create_db.sql
    echo "drop and create database end"
    rm -r *.out

    echo "load data begin"
    sh load_data_multi_t_2.sh ${mysql_host} ${mysql_user} ${mysql_password} ${mysql_port}
    sleep ${load_time}
    echo "load data end"

    mysql -h${mysql_host} -P${mysql_port} -u${mysql_user} -p${mysql_password} -Dtpcc_100 < CH-benCHmark/cr_tb_nrs.sql

    sleep 10
