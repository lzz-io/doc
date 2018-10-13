docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/jira .

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/jira registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/jira:1

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/jira
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/jira:1

#docker run -it --privileged -p 111:111 -p 111:111/udp -p 2049:2049 -p 2049:2049/udp registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/jira bash
# docker rm -f -v jira
# docker run -d --privileged \
# 	--name jira \
# 	-p 8090:8090 \
#     registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/jira

## for docker-compose
docker-compose down -v
# docker-compose down
docker-compose up -d
# docker-compose run jira bash
docker exec -it jira bash

## for docker stack
# docker stack rm jira
# docker stack deploy -c docker-compose.yml jira
