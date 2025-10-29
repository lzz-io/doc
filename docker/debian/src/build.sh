docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/debian .

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/debian registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/debian:1

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/debian
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/debian:1

# docker run -it -p 80:80 --name debian registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/debian bash
docker run -d -p 80:80 --privileged --name debian registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/debian

## for docker-compose
#docker-compose up
# docker-compose run app bash

## for docker stack
#docker stack deploy -c docker-compose.yml debian
