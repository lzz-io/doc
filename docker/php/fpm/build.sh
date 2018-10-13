# php-fpm
docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/php .

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/php registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/php:7-fpm

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/php
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/php:7-fpm


# nginx
docker build -f Dockerfile-nginx -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nginx-php .

docker images -a

#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nginx-php


docker-compose up


