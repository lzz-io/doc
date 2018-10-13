#!/bin/bash
set -e

echo `date`

LOG_FILE=/redis-cluster.log

echo "yes" | redis-trib.rb create --replicas 1 \
	10.0.1.101:6379 10.0.1.102:6379 10.0.1.103:6379 \
	10.0.1.104:6379 10.0.1.105:6379 10.0.1.106:6379 \
# echo "yes" | redis-trib.rb create --replicas 1 \
# 	192.168.56.101:7001 192.168.56.101:7002 192.168.56.101:7003 \
# 	192.168.56.101:7004 192.168.56.101:7005 192.168.56.101:7006 
# echo "yes" | redis-trib.rb create --replicas 1 \
# 	redis1:6379 redis2:6379 redis3:6379 \
# 	redis4:6379 redis5:6379 redis6:6379
	>> ${LOG_FILE} 

tail -f ${LOG_FILE} 

exec "$@"

## 在entrypoint脚本中使用exec
## 不使用exec的话，我们则不能顺利地关闭容器，因为SIGTERM信号会被bash脚本进程吞没。
## exec命令启动的进程可以取代脚本进程，因此所有的信号都会正常工作。