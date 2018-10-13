#!/bin/bash

# docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nexus .

# docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nexus registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nexus:1

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nexus

## for docker-compose
# docker-compose down -v
# # sleep 10
# docker network rm mynet
# docker network create -d overlay --subnet=10.0.0.0/16 --attachable mynet
# # docker-compose up
docker-compose up -d
    
#### for docker stack
# docker network create -d overlay mynet
# docker network create --driver overlay --subnet=10.0.0.0/16 mynet
# docker stack rm nexus
# # sleep 10
# docker stack deploy -c docker-compose.yml nexus
