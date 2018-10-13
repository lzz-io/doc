docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/rabbitmq .
# docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/rabbitmq:management ./management

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/rabbitmq registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/rabbitmq:1

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/rabbitmq
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/rabbitmq:management

## for docker-compose
docker-compose down
docker network rm mynet
docker network create -d overlay --subnet=10.0.0.0/16 --attachable mynet
# docker-compose up
docker-compose up -d
#docker-compose run rabbitmq bash
#docker run -d --name rabbitmq registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/rabbitmq
#docker exec -it rabbitmq bash
#docker run -d \
#	--name rabbitmq \
#	--mount 'type=volume,volume-opt=o=addr=192.168.56.101,volume-opt=device=:/,volume-opt=type=nfs4,source=data,target=/data' \
#    registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/rabbitmq
    
#### for docker stack
###echo y|docker network rm ingress
###docker network create --ingress --subnet=10.0.0.0/8 -d overlay ingress
# docker network create -d overlay mynet
#docker network create --driver overlay --subnet=10.0.0.0/16 mynet
#docker network create --subnet=10.1.0.0/16 -d overlay net-rabbitmq
###docker network create --subnet=10.0.0.0/8 -d overlay ingress
# docker stack rm rabbitmq
# # sleep 10
# docker stack deploy -c docker-compose.yml rabbitmq
# docker stack deploy -c docker-compose-single.yml rabbitmq1

# docker volume prune -f;docker system prune -f
sleep 10
docker exec rabbitmq2 rabbitmqctl stop_app
docker exec rabbitmq2 rabbitmqctl join_cluster --ram rabbit@rabbitmq1
docker exec rabbitmq2 rabbitmqctl start_app

docker exec rabbitmq3 rabbitmqctl stop_app
docker exec rabbitmq3 rabbitmqctl join_cluster rabbit@rabbitmq1
docker exec rabbitmq3 rabbitmqctl start_app

