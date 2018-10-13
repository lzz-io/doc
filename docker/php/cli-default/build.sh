# php php-cli
docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/php .

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/php registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/php:7
#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/php registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/php:7-cli

docker login -u 15590988@qq.com -p admin888 registry-vpc.cn-hongkong.aliyuncs.com
docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/php
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/php:7
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/php:7-cli

docker-compose up


