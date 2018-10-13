#!/bin/bash
set -e

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
# for example : CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
# if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
# 	set -- redis-server "$@"
# fi

# allow the container to be started with `--user`
# if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then

if [ "$1" = 'supervisord' -a "$(id -u)" = '0' ]; then
	# WORKDIR /data 当前目录定义在 Dockerfile 中
	chown -R redis .
	# chown -R redis /etc/supervisor/conf.d
	# exec gosu redis "$0" "$@"
	# exec "$@"
# fi

# if [ "$1" = 'supervisord' ]; then
	### Cluster
	# Settings
	# see Dockerfile EXPOSE 6379 7001 ... 7006
	PORT=7000
	TIMEOUT=2000
	NODES=6
	REPLICAS=1

	# Computed vars
	ENDPORT=$((PORT+NODES))
	HOSTS=""
	PORTS=""

	### start
	while [ $((PORT < ENDPORT)) != "0" ]; do
	    PORT=$((PORT+1))
	    echo "Starting redis $PORT"
	    # chown -R redis .
	    # exec gosu redis redis-server --port $PORT --cluster-enabled yes \
	    # 	--cluster-config-file nodes-${PORT}.conf --cluster-node-timeout $TIMEOUT \
	    # 	--appendonly yes --appendfilename appendonly-${PORT}.aof \
	    # 	--dbfilename dump-${PORT}.rdb --logfile ${PORT}.log --daemonize no &
	    
	    echo "[program:redis_${PORT}]" > /etc/supervisor/conf.d/redis_${PORT}.conf
	    echo "command=/usr/local/bin/redis-server --port $PORT --cluster-enabled yes 
	    			--cluster-config-file nodes-${PORT}.conf --cluster-node-timeout $TIMEOUT
	    			--appendonly yes --appendfilename appendonly-${PORT}.aof 
	    			--dbfilename dump-${PORT}.rdb --logfile ${PORT}.log --daemonize no" >> /etc/supervisor/conf.d/redis_${PORT}.conf
	    echo "autorstart=true" >> /etc/supervisor/conf.d/redis_${PORT}.conf
	    echo "autorestart=true" >> /etc/supervisor/conf.d/redis_${PORT}.conf
	    echo "user=redis" >> /etc/supervisor/conf.d/redis_${PORT}.conf
	    echo "stdout_logfile=/data/supervisor.log" >> /etc/supervisor/conf.d/redis_${PORT}.conf

	    PORTS="$PORTS $PORT"
	    HOSTS="$HOSTS 127.0.0.1:$PORT"
	done

	echo 'echo yes | ruby /usr/local/bin/redis-trib.rb create --replicas '$REPLICAS' '$HOSTS' \
			| cat >> /data/redis-trib.log' > /usr/local/bin/createcluster.sh
	echo "[program:redis_createcluster]" >> /etc/supervisor/conf.d/redis_createcluster.conf
	echo "command=sh /usr/local/bin/createcluster.sh" >> /etc/supervisor/conf.d/redis_createcluster.conf
	echo "autorstart=true" >> /etc/supervisor/conf.d/redis_createcluster.conf
	echo "autorestart=true" >> /etc/supervisor/conf.d/redis_createcluster.conf
	echo "user=redis" >> /etc/supervisor/conf.d/redis_createcluster.conf
	echo "stdout_logfile=/data/supervisor.log" >> /etc/supervisor/conf.d/redis_createcluster.conf

	# 启动 supervisor 服务
	exec "$@"

	# | cat 第二次创建集群会出错，忽略此错误，不想写排错逻辑； 也可用 || true，意义不同
	# echo $HOSTS
	# CMD='echo "yes"'" | ruby /usr/local/bin/redis-trib.rb create --replicas $REPLICAS $HOSTS"
	# echo $CMD
	# # CMD="$CMD | cat >> /data/redis-trib.log"
	# CMD="$CMD >> /data/redis-trib.log"
	# eval $CMD
	# echo $CMD
	# while [ 0 -eq 0 ]
	# do
	#     echo ".................. job begin  ..................."
	#     # ...... call your command here 在这里调用你的命令 ......
	#     exec eval $CMD
	#     # check and retry   
	#     if [ $? -eq 0 ]; then
	#         echo "--------------- job complete ---------------"
	#         break;
	#     else
	#         echo "...............error occur, retry in 2 seconds .........."
	#         sleep 2
	#     fi
	# done
	# exec echo "yes" | ruby /usr/local/bin/redis-trib.rb create --replicas $REPLICAS $HOSTS | cat >> /data/redis-trib.log

	# exec gosu redis tail -f /data/{ *.log *.aof }
	### Cluster
# fi
else
	exec "$@"
fi