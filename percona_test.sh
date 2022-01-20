#!/bin/bash

mysql_host="10.224.78.80"
mysql_user=root
mysql_password="123456"
mysql_port=3311

min_load_time=6000

for loop in 1 4 8 16 32 64 128 256 512 1024
do
    echo "drop and create database begin"
    mysql -h${mysql_host} -P${mysql_port} -u${mysql_user} -p${mysql_password} < create_db.sql
    rm -r *.out
    echo "drop and create database end"
    
    echo "load data begin"
    sh load_data_multi_t_2.sh ${mysql_host} ${mysql_user} ${mysql_password} ${mysql_host}
    sleep ${min_load_time}

    success_cnt=0
    until [ ${success_cnt} -eq 3 ]
    do
        sleep 60
        rm -r res
        grep "DATA LOADING COMPLETED SUCCESSFULLY" *_901.out > res
        success_cnt=`cat res | wc -l`
    done

    echo "load data end"
    
    echo "the test for threads num: $loop start"

    /usr/bin/expect <<-EOF
    set timeout 4800
    spawn ssh fanyang@10.224.153.191
    expect "*password*"
    send "123456\r"
    expect "#*"
    send "cd /home/fanyang/fanyang_home/tpcc-mysql-pro/ \r"
    expect "*$*"
    send "nohup sh begin_test_2.sh ${mysql_host} ${mysql_user} ${mysql_password} ${mysql_host} ${loop} & \r"
    expect "*test done*"
    send "exit\r"
    expect eof
EOF

    echo "the test for threads num: $loop end"
    sleep 10
done