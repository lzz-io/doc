#!/bin/bash

docker build -t lzz.io/hadoop-base .

# docker images -a
#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/hadoop registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/hadoop:1
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/hadoop

# server 1
docker network create -d=overlay --subnet=10.10.0.0/16 --attachable mynet


# server 1
# hadoop-base
docker rm -f hadoop-base
docker volume prune -f
docker rm -f hadoop-base
docker run -d --init --name hadoop-base lzz.io/hadoop-base
docker exec -it hadoop-base bash

