docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/elasticsearch ./elasticsearch
docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/kibana ./kibana
docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/logstash ./logstash

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/elasticsearch registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/elasticsearch:1

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/elasticsearch
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/elasticsearch:1

#docker run -it --privileged -p 111:111 -p 111:111/udp -p 2049:2049 -p 2049:2049/udp registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/elasticsearch bash
# docker rm -f -v elasticsearch
# docker run -d --privileged \
# 	--name elasticsearch \
# 	-p 8090:8090 \
#     registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/elasticsearch

## for docker-compose
docker-compose down -v
# docker-compose down
docker-compose up -d
# docker-compose run elasticsearch bash
docker exec -it logstash bash
# docker exec -it elasticsearch1 bash

## for docker stack
# docker stack rm elasticsearch
# docker stack deploy -c docker-compose.yml elasticsearch
