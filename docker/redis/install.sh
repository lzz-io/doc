#!/bin/bash

# every node
# 
mkdir -p /data/redis
echo "appendonly yes" >> /data/redis/redis.conf
echo "masterauth q1w2e3r4" >> /data/redis/redis.conf
echo "requirepass q1w2e3r4" >> /data/redis/redis.conf
chown 999 /data/redis/redis.conf
# # 
# mkdir -p /var/lib/docker/volumes/redis-db/_data
# echo "appendonly yes" >> /var/lib/docker/volumes/redis-db/_data/redis.conf
# echo "masterauth q1w2e3r4" >> /var/lib/docker/volumes/redis-db/_data/redis.conf
# echo "requirepass q1w2e3r4" >> /var/lib/docker/volumes/redis-db/_data/redis.conf
# # chown 999 /var/lib/docker/volumes/redis-db/_data/redis.conf


# server 1
docker network create -d=overlay --subnet=10.10.0.0/16 --attachable mynet

# redis
docker rm -f redis
docker volume prune -f
docker rm -f redis
docker run -d --restart always --network mynet \
        -p 6379:6379 \
        --hostname redis --name redis \
        -v redis-db:/data \
        -v /data/redis/redis.conf:/data/redis.conf \
        redis /data/redis.conf

# 
# docker service rm redis
# sleep 10
# docker volume prune -f
# docker service create --network mynet \
#         -p 6379:6379 \
#         --hostname redis --name redis \
#         --constraint 'node.hostname==node1' \
#         --mount type=volume,source=redis-db,destination=/data \
#         redis /data/redis.conf


# 设置密码
# 连接到每个实例上执行一遍
# redis-cli -a q1w2e3r4 -h redis
redis-cli -h redis
config set masterauth q1w2e3r4
config set requirepass q1w2e3r4
auth q1w2e3r4
config rewrite

############# The End

# test
# redis-cli -h 127.0.0.1 -p 6379 -a q1w2e3r4
# redis-cli -p 6379 -h redis
# auth q1w2e3r4
redis-cli -a q1w2e3r4 -p 6379 -h redis
keys *
config get requirepass


###############################################################################
## busybox 测试用，如ping等
###############################################################################
docker run -it --network mynet busybox sh

docker exec -it redis bash


