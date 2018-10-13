#!/bin/bash

# server 1
docker network create -d=overlay --subnet=10.10.0.0/16 --attachable mynet

# server 1
# zookeeper1
docker pull zookeeper

docker rm -f zookeeper1
docker volume prune -f
docker rm -f zookeeper1
docker run -d --restart always --network mynet \
        -p 2181:2181 \
        --hostname zookeeper1 --name zookeeper1 \
        --env ZOO_MY_ID=1 \
        --env ZOO_SERVERS="server.1=zookeeper1:2888:3888 server.2=zookeeper2:2888:3888 server.3=zookeeper3:2888:3888" \
        -v zookeeper1-data:/data \
        -v zookeeper1-log:/datalog \
        zookeeper


# server 2
# zookeeper2
docker pull zookeeper

docker rm -f zookeeper2
docker volume prune -f
docker rm -f zookeeper2
docker run -d --restart always --network mynet \
        -p 2181:2181 \
        --hostname zookeeper2 --name zookeeper2 \
        --env ZOO_MY_ID=2 \
        --env ZOO_SERVERS="server.1=zookeeper1:2888:3888 server.2=zookeeper2:2888:3888 server.3=zookeeper3:2888:3888" \
        -v zookeeper2-data:/data \
        -v zookeeper2-log:/datalog \
        zookeeper


# server 3
# zookeeper3
docker pull zookeeper

docker rm -f zookeeper3
docker volume prune -f
docker rm -f zookeeper3
docker run -d --restart always --network mynet \
        -p 2181:2181 \
        --hostname zookeeper3 --name zookeeper3 \
        --env ZOO_MY_ID=3 \
        --env ZOO_SERVERS="server.1=zookeeper1:2888:3888 server.2=zookeeper2:2888:3888 server.3=zookeeper3:2888:3888" \
        -v zookeeper3-data:/data \
        -v zookeeper3-log:/datalog \
        zookeeper
