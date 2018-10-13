#!/bin/bash

# 增强bash的tab命令补全功能
# bash-completion、bash-completion-extras
# 重新打开bash生效
yum install bash-completion* -y

yum update -y

yum install -y yum-utils \
        device-mapper-persistent-data \
        lvm2

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce

systemctl stop firewalld
systemctl disable firewalld
systemctl enable docker
systemctl start docker
systemctl status docker


# docker run -d --restart always \
#     -e TZ=CST-8 \
#     -e MYSQL_ROOT_PASSWORD=123456 \
#     -e character-set-server=utf8mb4 \
#     -e collation-server=utf8mb4_unicode_ci \
#     -v /opt/mysql:/var/lib/mysql \
#     --name mysql \
#     mysql

docker run -d --restart always \
    -e TZ=CST-8 -v /opt/nextcloud:/var/www/html \
    --name nextcloud -p 50080:80 \
    nextcloud
    # --link mysql \


