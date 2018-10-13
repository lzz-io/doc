docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis .
# docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis:management ./management

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis:1

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis:management

## for docker-compose
docker-compose down
docker network rm mynet
docker network create -d overlay --subnet=10.0.0.0/16 --attachable mynet
# docker-compose up
docker-compose up -d
#docker-compose run redis bash
#docker run -d --name redis registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis
#docker exec -it redis bash
#docker run -d \
#	--name redis \
#	--mount 'type=volume,volume-opt=o=addr=192.168.56.101,volume-opt=device=:/,volume-opt=type=nfs4,source=data,target=/data' \
#    registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis
    
#### for docker stack
###echo y|docker network rm ingress
###docker network create --ingress --subnet=10.0.0.0/8 -d overlay ingress
# docker network create -d overlay mynet
#docker network create --driver overlay --subnet=10.0.0.0/16 mynet
#docker network create --subnet=10.1.0.0/16 -d overlay net-redis
###docker network create --subnet=10.0.0.0/8 -d overlay ingress
# docker stack rm redis
# # sleep 10
# docker stack deploy -c docker-compose.yml redis
# docker stack deploy -c docker-compose-single.yml redis1
