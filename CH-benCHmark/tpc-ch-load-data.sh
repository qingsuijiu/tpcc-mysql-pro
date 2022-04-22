#!/bin/bash

mysql_host="127.0.0.1"
mysql_user="root"
mysql_password="123456"
mysql_port=3311
db="tpcc100"
scale=100  #仓库数

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

cd ..
# create db, table,index
mysql -h${mysql_host} -P${mysql_port} -u${mysql_user} -p${mysql_password} -e "drop database if exists ${db}"
mysql -h${mysql_host} -P${mysql_port} -u${mysql_user} -p${mysql_password} -e "create database ${db}"
mysql -h${mysql_host} -P${mysql_port} -u${mysql_user} -p${mysql_password} -D${db} < create_table.sql;
mysql -h${mysql_host} -P${mysql_port} -u${mysql_user} -p${mysql_password} -D${db} < add_fkey_idx.sql;
echo "create db, table,index done"

# load tpc-c data
sh load_data_multi_t_3.sh ${mysql_host} ${mysql_user} ${mysql_password} ${mysql_port} ${db} ${scale}
load_process_num=-1
while [ ${load_process_num} -ne 1 ] 
do
    sleep 60 
    ps -ef | grep tpcc_load > tpcc_load_num
    load_process_num=$(awk 'END {print NR}' tpcc_load_num)
    echo "tpcc_load_process_num : ${load_process_num}"
done
echo "load_data_multi end"

#load tpc-h data
mysql -h${mysql_host} -P${mysql_port} -u${mysql_user} -p${mysql_password} -D${db} < CH-benCHmark/cr_tb_nrs.sql
echo "load tpc-h data done" 
