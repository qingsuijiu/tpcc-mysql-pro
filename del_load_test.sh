#!/bin/bash

mysql_host="10.224.78.80"
mysql_user=root
mysql_password="123456"
mysql_port=3311
db="tpcc100"
scale=100  #仓库数

warm_time=600 #预热时间，s
running_time=3600 #执行时间，s
log_interval_time=10 #日志输出间隔时间

while getopts ":hupPdw:" opt; do
  case $opt in
    h)
      mysql_host=${OPTARG};;
    u)
      mysql_user=${OPTARG};;
    p)
      mysql_password=${OPTARG};;
    P)
      mysql_port=${OPTARG};;
    d)
      db=${OPTARG};;
    w)
      scale=${OPTARG};;
    W)
      warm_time=${OPTARG};;
    r)
      running_time=${OPTARG};;
    i)
      log_interval_time=${OPTARG};;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done



for loop in 1 4 8 16 32 64 128 256 512 1024
do
    echo "drop and create database begin"
    # create db, table,index
    mysql -h${mysql_host} -P${mysql_port} -u${mysql_user} -p${mysql_password} -e "drop database if exists ${db}"
    mysql -h${mysql_host} -P${mysql_port} -u${mysql_user} -p${mysql_password} -e "create database ${db}"
    mysql -h${mysql_host} -P${mysql_port} -u${mysql_user} -p${mysql_password} -D${db} < create_table.sql;
    mysql -h${mysql_host} -P${mysql_port} -u${mysql_user} -p${mysql_password} -D${db} < add_fkey_idx.sql;
    echo "drop and create database end"
    rm -r *.out
    
    echo "load data begin"
    sh load_data_multi_t_3.sh ${mysql_host} ${mysql_user} ${mysql_password} ${mysql_port} ${db} ${scale}
    load_process_num=-1
    while [ ${load_process_num} -ne 1 ] 
    do
        sleep 60 
        ps -ef | grep tpcc_load > tpcc_load_num
        load_process_num=$(awk 'END {print NR}' tpcc_load_num)
        echo "tpcc_load_process_num : ${load_process_num}"
    done
    echo "load data end"
    
    echo "the test for threads num: $loop start"
    sh begin_test_3.sh ${mysql_host} ${mysql_user} ${mysql_password} ${mysql_port} ${db} ${scale} ${warm_time} ${running_time} ${log_interval_time} ${loop}
    echo "the test for threads num: $loop end"
    sleep 10
done