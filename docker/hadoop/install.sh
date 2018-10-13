#!/bin/bash

docker build -t lzz.io/hadoop .

# docker images -a
#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/hadoop registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/hadoop:1
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/hadoop

# server 1
docker network create -d=overlay --subnet=10.10.0.0/16 --attachable mynet


# server 1
# hadoop1
docker rm -f hadoop1
docker volume prune -f
docker rm -f hadoop1
docker run -it --init lzz.io/hadoop bash
# sleep 5
# docker run -d --restart always --network mynet \
#         -p 9092:9092 \
#         --hostname hadoop1 --name hadoop1 \
#         --env BROKER_ID=1 \
#         --env ZK_CONNECT="zookeeper1:2181,zookeeper2:2181,zookeeper3:2181" \
#         -v hadoop1-data:/data \
#         lzz.io/hadoop

