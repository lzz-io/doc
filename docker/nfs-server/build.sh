docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nfsserver .

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nfsserver registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nfsserver:1

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nfsserver
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nfsserver:1

## for docker-compose
docker-compose up -d
#docker-compose run app bash
#docker run -it --privileged -p 111:111 -p 111:111/udp -p 2049:2049 -p 2049:2049/udp registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nfsserver bash
#docker run -d --privileged \
#	--name nfs \
#	-p 111:111 -p 111:111/udp \
#    -p 2049:2049 -p 2049:2049/udp \
#    registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nfsserver
    
## for docker stack
#docker stack deploy -c docker-compose.yml nfsserver
