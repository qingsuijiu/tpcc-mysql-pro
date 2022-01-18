#!/bin/bash

cmd=$1
mysql_host="10.26.36.136"
mysql_user=root
mysql_password="123456"
mysql_port=3311
db="tpcc100"
scale=100  #仓库数

./tpcc_load -h ${mysql_host} -P ${mysql_port} -d ${db} -u ${mysql_user} -p ${mysql_password} -w ${scale}                                                                                              

echo "load_data_single done"