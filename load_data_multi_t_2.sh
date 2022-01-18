#!/bin/bash

export LD_LIBRARY_PATH=/usr/local/mysql/lib/mysql/
mysql_host=$1
mysql_user=$2
mysql_password=$3
mysql_port=$4
db="tpcc100"
scale=1000  #仓库数
STEP=100

./tpcc_load -h ${mysql_host} -P ${mysql_port} -d ${db} -u ${mysql_user} -p ${mysql_password} -w ${scale} -l 1 -m 1 -n ${scale} >> 1.out &

x=1

while [ $x -le ${scale} ]
do
         echo $x $(( $x + $STEP - 1 ))
         ./tpcc_load -h ${mysql_host} -P ${mysql_port} -d ${db} -u ${mysql_user} -p ${mysql_password} -w ${scale} -l 2 -m $x -n $(( $x + $STEP - 1 ))  >> 2_$x.out &
         ./tpcc_load -h ${mysql_host} -P ${mysql_port} -d ${db} -u ${mysql_user} -p ${mysql_password} -w ${scale} -l 3 -m $x -n $(( $x + $STEP - 1 ))  >> 3_$x.out &
         ./tpcc_load -h ${mysql_host} -P ${mysql_port} -d ${db} -u ${mysql_user} -p ${mysql_password} -w ${scale} -l 4 -m $x -n $(( $x + $STEP - 1 ))  >> 4_$x.out &
          x=$(( $x + $STEP ))
done

echo "load_data_multi done"