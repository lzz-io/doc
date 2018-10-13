#!/bin/bash

# every node
mkdir -p /data/redis
echo "cluster-enabled yes" > /data/redis/redis.conf
echo "cluster-config-file nodes.conf" >> /data/redis/redis.conf
echo "cluster-node-timeout 5000" >> /data/redis/redis.conf
echo "appendonly yes" >> /data/redis/redis.conf
chown 999 /data/redis/redis.conf

# 机器规划
# 主      --> 备
# redis1 --> redis4
# redis2 --> redis5
# redis3 --> redis6
# 部署
# server1   redis1  redis6
# server2   redis2  redis4
# server3   redis3  redis5
# redis1    10.10.0.101
# redis2    10.10.0.102
# redis3    10.10.0.103
# redis4    10.10.0.104
# redis5    10.10.0.105
# redis6    10.10.0.106

# server 1
docker network create -d=overlay --subnet=10.10.0.0/16 --attachable mynet

# redis1
docker rm -f redis1
docker volume prune -f
docker rm -f redis1
docker run -d --restart always --network mynet \
        -p 56379:6379 \
        --hostname redis1 --name redis1 \
        --ip=10.10.0.101 \
        -v redis1-db:/data \
        -v /data/redis/redis.conf:/data/redis.conf \
        redis /data/redis.conf

# redis6
docker rm -f redis6
docker volume prune -f
docker rm -f redis6
docker run -d --restart always --network mynet \
        -p 56380:6379 \
        --hostname redis6 --name redis6 \
        --ip=10.10.0.106 \
        -v redis6-db:/data \
        -v /data/redis/redis.conf:/data/redis.conf \
        redis /data/redis.conf

# server 2

# redis2
docker rm -f redis2
docker volume prune -f
docker rm -f redis2
docker run -d --restart always --network mynet \
        -p 56379:6379 \
        --hostname redis2 --name redis2 \
        --ip=10.10.0.102 \
        -v redis2-db:/data \
        -v /data/redis/redis.conf:/data/redis.conf \
        redis /data/redis.conf

# redis4
docker rm -f redis4
docker volume prune -f
docker rm -f redis4
docker run -d --restart always --network mynet \
        -p 56380:6379 \
        --hostname redis4 --name redis4 \
        --ip=10.10.0.104 \
        -v redis4-db:/data \
        -v /data/redis/redis.conf:/data/redis.conf \
        redis /data/redis.conf

# server 3
# redis3
docker rm -f redis3
docker volume prune -f
docker rm -f redis3
docker run -d --restart always --network mynet \
        -p 56379:6379 \
        --hostname redis3 --name redis3 \
        --ip=10.10.0.103 \
        -v redis3-db:/data \
        -v /data/redis/redis.conf:/data/redis.conf \
        redis /data/redis.conf

# redis5
docker rm -f redis5
docker volume prune -f
docker rm -f redis5
docker run -d --restart always --network mynet \
        -p 56380:6379 \
        --hostname redis5 --name redis5 \
        --ip=10.10.0.105 \
        -v redis5-db:/data \
        -v /data/redis/redis.conf:/data/redis.conf \
        redis /data/redis.conf


####################################
# 初始化
# in server 1 
####################################
docker run -it --network mynet redis bash

# <<
    apt-get update -y; \
    apt-get install -y \
        ruby-redis \
        wget; \
    wget -O /usr/local/bin/redis-trib.rb "http://download.redis.io/redis-stable/src/redis-trib.rb"; \
    chmod +x /usr/local/bin/redis-trib.rb; \
    \
    echo yes | ruby /usr/local/bin/redis-trib.rb create --replicas 1 \
        10.10.0.101:6379 10.10.0.102:6379 10.10.0.103:6379 \
        10.10.0.104:6379 10.10.0.105:6379 10.10.0.106:6379
# <<

# 设置密码
# 连接到每个实例上执行一遍
# redis-cli -h redis2
# redis-cli -h redis3
# redis-cli -h redis4
# redis-cli -h redis5
# redis-cli -h redis6
# redis-cli -a q1w2e3r4 -h redis1
redis-cli -h redis1
config set masterauth q1w2e3r4
config set requirepass q1w2e3r4
auth q1w2e3r4
config rewrite

############# The End

# test
# redis-cli -h 127.0.0.1 -p 6379 -a q1w2e3r4
# redis-cli -p 6379 -h redis1
# auth q1w2e3r4
redis-cli -a q1w2e3r4 -p 6379 -h redis1
keys *
config get requirepass


###############################################################################
## busybox 测试用，如ping等
###############################################################################
docker run -it --network mynet busybox sh

docker exec -it redis11 bash


