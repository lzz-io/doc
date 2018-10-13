docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/helloworld .

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/helloworld registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/helloworld:1

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/helloworld
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/helloworld:1

## for docker-compose
#docker-compose up -d
docker-compose run app bash
#docker run -it --privileged -p 111:111 registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/helloworld bash
#docker run -d \
#	--name helloworld \
#	--mount 'type=volume,volume-opt=o=addr=192.168.56.101,volume-opt=device=:/,volume-opt=type=nfs4,source=data,target=/data' \
#    registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/helloworld
    
## for docker stack
#docker stack deploy -c docker-compose.yml helloworld
