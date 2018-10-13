#!/bin/bash
set -e

 
echo 'starting rpcbind'
/usr/sbin/rpcbind -i

echo 'starting rpc.statd'
/usr/sbin/rpc.statd #--no-notify --port 32765 --outgoing-port 32766
sleep .5

echo 'starting rpc.nfsd'
echo $(pgrep 'nfsd')
/usr/sbin/rpc.nfsd -V4 -N3 -N2 -d 8

echo 'starting rpc.mountd'
/usr/sbin/rpc.mountd -V4 -N3 -N2 #--port 32767

/usr/sbin/exportfs -ra


echo "started at `date`"

exec "$@"

## 在entrypoint脚本中使用exec
## 不使用exec的话，我们则不能顺利地关闭容器，因为SIGTERM信号会被bash脚本进程吞没。
## exec命令启动的进程可以取代脚本进程，因此所有的信号都会正常工作。