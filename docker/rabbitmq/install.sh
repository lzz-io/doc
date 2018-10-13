#!/bin/bash


# 机器规划
# 主      --> 备
# 部署

# server 1
docker network create -d=overlay --subnet=10.10.0.0/16 --attachable mynet

# rabbitmq
docker pull rabbitmq:management

docker rm -f rabbitmq
docker volume prune -f
docker rm -f rabbitmq
docker run -d --restart always --network mynet \
        -p 5672:5672 -p 15672:15672 \
        --hostname rabbitmq --name rabbitmq \
        -v rabbitmq-db:/var/lib/rabbitmq \
        --env RABBITMQ_DEFAULT_USER=user \
        --env RABBITMQ_DEFAULT_PASS=q1w2e3r4 \
        rabbitmq:management

# docker pull rabbitmq:management
# docker service rm rabbitmq
# sleep 10
# docker volume prune -f
# docker service create --network mynet \
#         -p 5672:5672 -p 15672:15672 \
#         --hostname rabbitmq --name rabbitmq \
#         --constraint 'node.hostname==node1' \
#         --mount type=volume,source=rabbitmq-db,destination=/var/lib/rabbitmq \
#         --env RABBITMQ_DEFAULT_USER=user \
#         --env RABBITMQ_DEFAULT_PASS=q1w2e3r4 \
#         rabbitmq:management



###############################################################################
## busybox 测试用，如ping等
###############################################################################
docker run -it --network mynet busybox sh

docker exec -it rabbitmq bash


