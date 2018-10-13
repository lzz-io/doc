docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/httpd .

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/centos registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/centos:1

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/centos
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/centos:1

## for docker-compose
# docker-compose up -d
#docker-compose run app bash
docker run -d -p 80:80 -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name httpd registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/httpd
# docker run -it --privileged -p 111:111 -p 111:111/udp -p 2049:2049 -p 2049:2049/udp registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/centos bash
# docker run -d --privileged \
# 	--name nfs \
# 	-p 111:111 -p 111:111/udp \
#     -p 2049:2049 -p 2049:2049/udp \
#     registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/centos
    
## for docker stack
#docker stack deploy -c docker-compose.yml centos
