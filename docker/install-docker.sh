#!/bin/bash

# 增强bash的tab命令补全功能
# bash-completion、bash-completion-extras
# 重新打开bash生效
# yum install bash-completion* -y
yum install bash-com* -y

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

docker swarm init
# docker swarm init --advertise-addr=192.168.56.100

# docker network create -d overlay --subnet=10.0.0.0/16 --attachable mynet
