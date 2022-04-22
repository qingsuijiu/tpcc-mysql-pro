#!/bin/bash

ps -ef | grep tpcc_load |  awk '{print $2}' > tpcc_load_process_id
for line in `cat tpcc_load_process_id`
do
  echo "kill process : $line"
  kill -9 $line
done