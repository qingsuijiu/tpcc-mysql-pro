#!/bin/bash

mysql_host=$1
mysql_user=$2
mysql_password=$3
mysql_port=$4
db=$5
scale=$6  #仓库数
warm_time=$7 #预热时间，s
running_time=$8 #执行时间，s
log_interval_time=$9 #日志输出间隔时间
threads=$10 #线程数
report_name="tpcc_report_${threads}threads_${running_time}time.txt"

./tpcc_start -h ${mysql_host} -P ${mysql_port} -d ${db} -u ${mysql_user} -p ${mysql_password} -w ${scale} -c ${threads} -r ${warm_time} -l ${running_time} -i ${log_interval_time} >> ${report_name}

echo "test done"