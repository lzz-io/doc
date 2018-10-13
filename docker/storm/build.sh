#!/bin/bash

# docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/storm .

# docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/storm registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/storm:1

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/storm

## for docker-compose
# docker-compose down -v
# # sleep 10
# docker network rm mynet
# docker network create -d overlay --subnet=10.0.0.0/16 --attachable mynet
# # docker-compose up
# docker-compose up -d
    
#### for docker stack
# docker network create -d overlay mynet
docker network create --driver overlay --subnet=10.0.0.0/16 mynet
docker stack rm storm
# sleep 10
docker stack deploy -c docker-compose.yml storm
