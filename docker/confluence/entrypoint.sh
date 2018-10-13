#!/bin/bash
set -e

echo "started at `date`"

exec "$@"

## 在entrypoint脚本中使用exec
## 不使用exec的话，我们则不能顺利地关闭容器，因为SIGTERM信号会被bash脚本进程吞没。
## exec命令启动的进程可以取代脚本进程，因此所有的信号都会正常工作。