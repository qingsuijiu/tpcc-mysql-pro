原仓库地址：https://github.com/Percona-Lab/tpcc-mysql
在原仓库基础上做出的更改：
1. 修复了一个逻辑bug，具体见博客：https://blog.csdn.net/qingsui9/article/details/122405970
2. 增加了统计95%平均时延和99%平均时延的功能，结果输出在最后
3. 增加了4个脚本文件：
- load_data_single_t.sh : 单进程的灌数据
- load_data_multi_t.sh : 多进程的灌数据，只需根据自己的具体配置修改变量即可使用
- begin_test.sh : 进行一次tpcc测试，同样根据自己的具体配置修改变量即可使用，后缀本次测试的线程数，如：
```
sh begin_test.sh 16
```
- change_thread_num_test.sh : 改变线程数进行多组tpcc测试
