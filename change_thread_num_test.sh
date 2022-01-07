#!/bin/bash
for loop in 16 32 64 128 256 512 1024
do
        echo "the test for threads num: $loop start"
        sh begin_test.sh ${loop}
        echo "the test for threads num: $loop end"
done