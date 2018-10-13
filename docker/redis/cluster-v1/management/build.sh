docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis:management .

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis:1

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis:1

## for docker-compose
#docker-compose up -d
#docker-compose run redis bash
#docker run -d --name redis registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis
#docker exec -it redis bash
#docker run -d \
#	--name redis \
#	--mount 'type=volume,volume-opt=o=addr=192.168.56.101,volume-opt=device=:/,volume-opt=type=nfs4,source=data,target=/data' \
#    registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/redis
    
## for docker stack
#docker stack deploy -c docker-compose.yml redis
