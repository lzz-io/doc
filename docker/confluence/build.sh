docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/confluence .

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/confluence registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/confluence:1

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/confluence
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/confluence:1

#docker run -it --privileged -p 111:111 -p 111:111/udp -p 2049:2049 -p 2049:2049/udp registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/confluence bash
# docker rm -f -v confluence
# docker run -d --privileged \
# 	--name confluence \
# 	-p 8090:8090 \
#     registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/confluence

## for docker-compose
# docker-compose down -v
docker-compose down
docker-compose up -d
# #docker-compose run app bash

# docker exec -it confluence bash

## for docker stack
# docker stack rm confluence
# docker stack deploy -c docker-compose.yml confluence
