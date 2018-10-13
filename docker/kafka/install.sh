#!/bin/bash

docker build -t lzz.io/kafka .

# docker images -a
#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/kafka registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/kafka:1
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/kafka

# server 1
docker network create -d=overlay --subnet=10.10.0.0/16 --attachable mynet


# server 1
# kafka1
docker rm -f kafka1
docker volume prune -f
docker rm -f kafka1
sleep 5
docker run -d --restart always --network mynet \
        -p 9092:9092 \
        --hostname kafka1 --name kafka1 \
        --env BROKER_ID=1 \
        --env ZK_CONNECT="zookeeper1:2181,zookeeper2:2181,zookeeper3:2181" \
        -v kafka1-data:/data \
        lzz.io/kafka


# server 2
# kafka2
docker rm -f kafka2
docker volume prune -f
docker rm -f kafka2
sleep 5
docker run -d --restart always --network mynet \
        -p 9092:9092 \
        --hostname kafka2 --name kafka2 \
        --env BROKER_ID=2 \
        --env ZK_CONNECT="zookeeper1:2181,zookeeper2:2181,zookeeper3:2181" \
        -v kafka2-data:/data \
        lzz.io/kafka


# server 3
# kafka3
docker rm -f kafka3
docker volume prune -f
docker rm -f kafka3
sleep 5
docker run -d --restart always --network mynet \
        -p 9092:9092 \
        --hostname kafka3 --name kafka3 \
        --env BROKER_ID=3 \
        --env ZK_CONNECT="zookeeper1:2181,zookeeper2:2181,zookeeper3:2181" \
        -v kafka3-data:/data \
        lzz.io/kafka

