#!/bin/bash

mysql_host="10.224.78.80"
mysql_user=root
mysql_password="123456"
mysql_port=3311
db="tpcc100"
scale=1000  #仓库数
warm_time=600 #预热时间，s
running_time=3600 #执行时间，s
log_interval_time=10 #日志输出间隔时间
threads=$1 #线程数
report_name="tpcc_report_$1threads_${running_time}time.txt"

./tpcc_start -h ${mysql_host} -P ${mysql_port} -d ${db} -u ${mysql_user} -p ${mysql_password} -w ${scale} -c ${threads} -r ${warm_time} -l ${running_time} -i ${log_interval_time} >> ${report_name}

echo "test done"