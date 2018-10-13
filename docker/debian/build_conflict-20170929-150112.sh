docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/debian .

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/debian registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/debian:1

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/debian
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/debian:1

## for docker-compose
#docker-compose up
docker-compose run app bash

## for docker stack
#docker stack deploy -c docker-compose.yml debian
