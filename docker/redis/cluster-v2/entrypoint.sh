#!/bin/bash
set -e

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
# for example : CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
# if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
# 	set -- redis-server "$@"
# fi

# allow the container to be started with `--user`
if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
	chown -R redis .
	# exec gosu redis "$0" "$@"
# fi

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

	### start
	while [ $((PORT < ENDPORT)) != "0" ]; do
	    PORT=$((PORT+1))
	    echo "Starting $PORT"
	    # chown -R redis .
	    exec gosu redis redis-server --port $PORT --cluster-enabled yes \
	    	--cluster-config-file nodes-${PORT}.conf --cluster-node-timeout $TIMEOUT \
	    	--appendonly yes --appendfilename appendonly-${PORT}.aof \
	    	--dbfilename dump-${PORT}.rdb --logfile ${PORT}.log --daemonize no &
	    
	    HOSTS="$HOSTS 127.0.0.1:$PORT"
	done

	# | cat 第二次创建集群会出错，忽略此错误，不想写排错逻辑； 也可用 || true，意义不同
	echo "yes" | ruby /usr/local/bin/redis-trib.rb create --replicas $REPLICAS $HOSTS | cat

	exec gosu redis tail -f /data/{ *.log *.aof }
	### Cluster
fi

exec "$@"