原仓库地址：https://github.com/Percona-Lab/tpcc-mysql
## 在原仓库基础上做出的更改：
1. 修复了一个逻辑bug，具体见博客：https://blog.csdn.net/qingsui9/article/details/122405970
2. 增加了统计整轮测试p95,p99,p999的功能，结果输出在最后
3. 增加了在测试前输出本地时间的功能，方便调监控工具查看运行状况
4. 增加了多个脚本文件：
- load_data_single_t.sh : 单进程的灌数据
- load_data_multi_t.sh : 多进程的灌数据，只需根据自己的具体配置修改变量即可使用
- begin_test.sh : 进行一次tpcc测试，同样根据自己的具体配置修改变量即可使用，后缀本次测试的线程数，如：
```
sh begin_test.sh 16
```
- change_thread_num_test.sh : 改变线程数进行多组tpcc测试（后发现在一份数据上连续测试，会使得初始数据量发生改变，没有很好的控制变量，故启用该脚本，采用灌一次测一次删一次的流程，可参靠del_load_test.sh）
- del_load_test.sh: 灌一次测一次删一次的流程，del_load_test.sh较为通用，适合其他同学使用。该脚本使用方式与下文中的tpc-ch-load-data.sh使用方式类似。

## 之后需要添加的修改：
在灌数据时，存在无限循环报错，以至于报错日志将整个磁盘占满，其他端的报错日志存不下，问题定位受阻。
预期未来将重复报错时间间隔拉长，或限制重复报错次数

# CH-BenCHmark （oltp、olap混合负载测试）
## 灌数据
在 ../tpcc-mysql-pro/CH-benCHmark目录下
```
sh tpc-ch-load-data.sh
```
打开上述脚本后，有六个重要变量：mysql_host, mysql_user, mysql_password, mysql_port, db, scale.
前五个用过mysql应该都能理解，scale这个值是TPC-C中的仓库数量，简单来说控制了测试数据的大小，当scale=100，最后的总数据大约为9G。

**修改这些参数的方式**
1. 可以在脚本中手动改这些值
2. 根据以下规则在命令行中限定：
```
sh tpc-ch-load-data.sh -h 你的mysql_host -u 你的mysql_user -p 你的mysql_password -P 你的mysql_port -d 你想要灌数据的数据库名 -w 仓库数量
```
如果其中某项没有设置，就会采用脚本中填写的默认值.

## 测试
TPC-C（OLTP）的负载可以通过修改TPC-C测试脚本中的连接数（thread）就可以控制；
TPC-H（OLAP）的负载可以通过nohup命令起多个测试脚本模拟多个OLAP流来实现。
